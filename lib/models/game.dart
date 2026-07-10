/// Menandai dari mana data game ini berasal.
/// manual = user input sendiri lewat form Add Game
/// steam  = ditarik otomatis dari Steam API
enum GameSource { manual, steam }

class Game {
  final String id;
  final String name;
  final String genre;
  final String description;
  final String imagePath;
  final bool isNetworkImage;
  final String status;
  final int releaseYear;
  final GameSource source;

  const Game({
    required this.id,
    required this.name,
    required this.genre,
    required this.description,
    required this.imagePath,
    this.isNetworkImage = false,
    required this.status,
    required this.releaseYear,
    this.source = GameSource.manual,
  });

  /// Bikin salinan Game dengan sebagian field diganti.
  /// Dipakai tiap kali cuma perlu update sebagian data (misal status
  /// atau hasil fetch detail), tanpa perlu nulis ulang semua field.
  Game copyWith({
    String? genre,
    String? description,
    String? status,
    int? releaseYear,
  }) {
    return Game(
      id: id,
      name: name,
      genre: genre ?? this.genre,
      description: description ?? this.description,
      imagePath: imagePath,
      isNetworkImage: isNetworkImage,
      status: status ?? this.status,
      releaseYear: releaseYear ?? this.releaseYear,
      source: source,
    );
  }

  /// Dipakai nanti waktu convert data mentah dari Steam GetOwnedGames
  /// jadi objek Game yang dipahami app ini.
  factory Game.fromSteamJson(Map<String, dynamic> json) {
    final appId = json['appid'].toString();

    return Game(
      id: 'steam_$appId',
      name: json['name'] ?? 'Unknown',
      genre: 'Steam Game',
      description: '',
      // Versi "_2x" ini yang resolusi aslinya beneran 600x900.
      // Tanpa _2x, nama filenya sama tapi isinya cuma 300x450, pecah
      // kalau ditampilin di card yang agak besar.
      imagePath:
      'https://cdn.akamai.steamstatic.com/steam/apps/$appId/library_600x900_2x.jpg',
      isNetworkImage: true,
      status: 'Next Up',
      releaseYear: 0,
      source: GameSource.steam,
    );
  }

  /// Dipakai buat nyimpen ke SharedPreferences (diubah jadi JSON string)
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'genre': genre,
    'description': description,
    'imagePath': imagePath,
    'isNetworkImage': isNetworkImage,
    'status': status,
    'releaseYear': releaseYear,
    'source': source.name,
  };

  /// Dipakai buat baca balik dari SharedPreferences
  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json['id'],
    name: json['name'],
    genre: json['genre'],
    description: json['description'],
    imagePath: json['imagePath'],
    isNetworkImage: json['isNetworkImage'] ?? false,
    status: json['status'],
    releaseYear: json['releaseYear'],
    source: GameSource.values.firstWhere(
          (e) => e.name == json['source'],
      orElse: () => GameSource.manual,
    ),
  );
}