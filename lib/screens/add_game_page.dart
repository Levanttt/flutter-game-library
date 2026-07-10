import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../models/game.dart';
import '../providers/game_provider.dart';
import 'steam_login_page.dart';

class AddGamePage extends StatefulWidget {
  const AddGamePage({super.key});

  @override
  State<AddGamePage> createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  // Ganti ini kalau URL worker kamu beda
  static const _backendUrl = 'https://steam-backend.luthfiardi66.workers.dev';

  bool _isSyncing = false;

  Future<void> _connectSteam() async {
    // Step 1: buka WebView login, tunggu sampai dapet SteamID
    final steamId = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const SteamLoginPage()),
    );

    if (steamId == null || !mounted) return;

    setState(() => _isSyncing = true);

    try {
      // Step 2: minta backend narik daftar game dari Steam
      final response = await http.get(
        Uri.parse('$_backendUrl/games?steamid=$steamId'),
      );

      if (response.statusCode != 200) {
        throw Exception('Backend membalas status ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      final gamesJson = data['response']?['games'] as List?;

      if (gamesJson == null || gamesJson.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Enggak ada game ditemukan. Pastikan profile Steam kamu public.',
            ),
          ),
        );
        return;
      }

      // Step 3: convert tiap item JSON jadi objek Game
      final games = gamesJson
          .map((json) => Game.fromSteamJson(json as Map<String, dynamic>))
          .toList();

      // Step 4: masukin ke provider, otomatis kesave ke local storage
      if (!mounted) return;
      await context.read<GameProvider>().syncFromSteam(games);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${games.length} game berhasil diimport')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal sync: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: const Text('Add Game', style: AppTextStyles.appBarTitle),
      ),
      body: Center(
        child: _isSyncing
            ? const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Mengambil data dari Steam...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
            : Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.card,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _connectSteam,
                  icon: const Icon(Icons.link, color: Colors.white),
                  label: const Text(
                    'Import dari Steam',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: form tambah game manual
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Tambah Manual',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}