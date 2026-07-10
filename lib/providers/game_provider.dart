import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/storage_service.dart';

/// Satu-satunya sumber kebenaran soal daftar game di app ini.
/// Semua screen baca data lewat provider ini, bukan dari list statis lagi.
/// Begitu integrasi Steam jadi, cukup tambah method syncFromSteam() di sini,
/// screen-screen yang sudah ada tidak perlu diubah.
class GameProvider extends ChangeNotifier {
  final StorageService _storage = StorageService();
  List<Game> _games = [];

  List<Game> get allGames => _games;
  List<Game> get onGoing =>
      _games.where((g) => g.status == 'On Going').toList();
  List<Game> get nextUp =>
      _games.where((g) => g.status == 'Next Up').toList();

  Future<void> loadFromStorage() async {
    _games = await _storage.loadGames();
    notifyListeners();
  }

  Future<void> addGame(Game game) async {
    _games.add(game);
    notifyListeners();
    await _storage.saveGames(_games);
  }

  Future<void> removeGame(String id) async {
    _games.removeWhere((g) => g.id == id);
    notifyListeners();
    await _storage.saveGames(_games);
  }

  Future<void> updateGameStatus(String id, String newStatus) async {
    final index = _games.indexWhere((g) => g.id == id);
    if (index == -1) return;
    final old = _games[index];
    _games[index] = Game(
      id: old.id,
      name: old.name,
      genre: old.genre,
      description: old.description,
      imagePath: old.imagePath,
      isNetworkImage: old.isNetworkImage,
      status: newStatus,
      releaseYear: old.releaseYear,
      source: old.source,
    );
    notifyListeners();
    await _storage.saveGames(_games);
  }

// Nanti dipanggil setelah integrasi Steam API jadi:
// Future<void> syncFromSteam(List<Game> steamGames) async { ... }
}