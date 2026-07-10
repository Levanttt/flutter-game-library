import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game.dart';

/// Satu-satunya file yang boleh langsung sentuh SharedPreferences.
/// Kalau nanti pindah ke penyimpanan lain (misal sqflite atau Hive),
/// cukup ubah isi file ini saja, bagian lain app tidak perlu tahu.
class StorageService {
  static const _gamesKey = 'saved_games';

  Future<void> saveGames(List<Game> games) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = games.map((g) => g.toJson()).toList();
    await prefs.setString(_gamesKey, jsonEncode(jsonList));
  }

  Future<List<Game>> loadGames() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_gamesKey);
    if (raw == null) return [];

    final jsonList = jsonDecode(raw) as List;
    return jsonList
        .map((j) => Game.fromJson(j as Map<String, dynamic>))
        .toList();
  }
}