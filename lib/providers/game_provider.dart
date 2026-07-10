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
    _games[index] = _games[index].copyWith(status: newStatus);
    notifyListeners();
    await _storage.saveGames(_games);
  }

  /// Dipanggil setelah SteamStoreService berhasil narik genre,
  /// deskripsi, dan tahun rilis buat satu game. Hasilnya kesimpen
  /// permanen, jadi enggak perlu fetch ulang tiap buka detail page
  /// yang sama.
  Future<void> updateGameDetails(
      String id, {
        required String genre,
        required String description,
        required int releaseYear,
      }) async {
    final index = _games.indexWhere((g) => g.id == id);
    if (index == -1) return;
    _games[index] = _games[index].copyWith(
      genre: genre,
      description: description,
      releaseYear: releaseYear,
    );
    notifyListeners();
    await _storage.saveGames(_games);
  }

  Future<void> syncFromSteam(List<Game> steamGames) async {
    for (final game in steamGames) {
      final alreadyExists = _games.any((g) => g.id == game.id);
      if (!alreadyExists) {
        _games.add(game);
      }
    }
    notifyListeners();
    await _storage.saveGames(_games);
  }
}