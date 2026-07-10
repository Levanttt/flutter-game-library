import 'dart:convert';
import 'package:http/http.dart' as http;

/// Hasil parsing dari Steam Store API buat satu game.
class SteamGameDetails {
  final String genre;
  final String description;
  final int releaseYear;

  SteamGameDetails({
    required this.genre,
    required this.description,
    required this.releaseYear,
  });
}

class SteamStoreService {
  Future<SteamGameDetails?> fetchDetails(String appId) async {
    final url = Uri.parse(
      'https://store.steampowered.com/api/appdetails?appids=$appId&l=indonesian',
    );

    final response = await http.get(url);
    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final appData = data[appId];

    if (appData == null || appData['success'] != true) return null;

    final details = appData['data'];

    final genres = (details['genres'] as List?)
        ?.map((g) => g['description'] as String)
        .join(', ') ??
        'Unknown';

    final description = details['short_description'] as String? ?? '';

    final releaseDateStr = details['release_date']?['date'] as String? ?? '';
    final yearMatch = RegExp(r'\d{4}').firstMatch(releaseDateStr);
    final releaseYear =
    yearMatch != null ? int.parse(yearMatch.group(0)!) : 0;

    return SteamGameDetails(
      genre: genres,
      description: description,
      releaseYear: releaseYear,
    );
  }
}