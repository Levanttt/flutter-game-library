import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../models/game.dart';
import '../providers/game_provider.dart';
import '../services/steam_store_service.dart';
import '../widgets/game_image.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _storeService = SteamStoreService();
  Game? _game;
  bool _isLoadingDetails = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ModalRoute cuma bisa diakses setelah widget kesambung ke tree,
    // makanya diambil di sini, bukan di initState.
    if (_game == null) {
      _game = ModalRoute.of(context)!.settings.arguments as Game;
      _maybeFetchDetails();
    }
  }

  Future<void> _maybeFetchDetails() async {
    final game = _game!;

    // Cuma fetch kalau ini game dari Steam DAN belum pernah kesimpen
    // deskripsinya. Game manual enggak butuh ini sama sekali.
    final needsFetch = game.source == GameSource.steam && game.description.isEmpty;
    if (!needsFetch) return;

    setState(() => _isLoadingDetails = true);

    final appId = game.id.replaceFirst('steam_', '');
    final details = await _storeService.fetchDetails(appId);

    if (!mounted) return;

    if (details != null) {
      await context.read<GameProvider>().updateGameDetails(
        game.id,
        genre: details.genre,
        description: details.description,
        releaseYear: details.releaseYear,
      );
    }

    if (mounted) setState(() => _isLoadingDetails = false);
  }

  @override
  Widget build(BuildContext context) {
    // Ambil versi terbaru dari provider, biar begitu fetch selesai
    // dan data keupdate, halaman ini otomatis nampilin yang terbaru.
    final liveGame = context.watch<GameProvider>().allGames.firstWhere(
          (g) => g.id == _game!.id,
      orElse: () => _game!,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: Text(liveGame.name, style: AppTextStyles.appBarTitle),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/avatar',
                  arguments: liveGame.imagePath,
                );
              },
              child: GameImage(
                game: liveGame,
                width: double.infinity,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(liveGame.name, style: AppTextStyles.heading),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(liveGame.genre, style: AppTextStyles.label),
                      if (liveGame.releaseYear > 0)
                        Text('${liveGame.releaseYear}', style: AppTextStyles.label),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_isLoadingDetails)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    Text(
                      liveGame.description.isEmpty
                          ? 'Deskripsi belum tersedia.'
                          : liveGame.description,
                      style: AppTextStyles.body,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}