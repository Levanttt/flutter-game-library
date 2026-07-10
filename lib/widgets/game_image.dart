import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/game.dart';

/// Satu widget buat nampilin gambar game, entah dari asset lokal
/// (game input manual) atau dari URL (game hasil sync Steam).
/// Dipakai di list_page dan detail_page biar logic pilih
/// Image.network vs Image.asset enggak ditulis ulang di dua tempat.
class GameImage extends StatelessWidget {
  final Game game;
  final double? width;
  final double? height;
  final BoxFit fit;

  const GameImage({
    super.key,
    required this.game,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (game.isNetworkImage) {
      return Image.network(
        game.imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          color: AppColors.card,
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    }

    return Image.asset(
      game.imagePath,
      width: width,
      height: height,
      fit: fit,
    );
  }
}