import 'package:flutter/material.dart';

class Game {
  final String name;
  final String genre;
  final String description;
  final String imagePath;
  final String status;

  Game({
    required this.name,
    required this.genre,
    required this.description,
    required this.imagePath,
    required this.status,
  });
}

final List<Game> games = [
  Game(
    name: 'The Witcher 3',
    genre: 'Action RPG',
    description: 'A story-driven open world RPG set in a visually stunning fantasy universe.',
    imagePath: 'assets/images/the_witcher_3.jpg',
    status: 'On Going',
  ),
  Game(
    name: 'Undertale',
    genre: 'RPG',
    description: 'A game where you don\'t have to kill anyone. Every monster can be spared.',
    imagePath: 'assets/images/undertale.png',
    status: 'On Going',
  ),
  Game(
    name: 'Metal Gear Solid V',
    genre: 'Stealth Action',
    description: 'An open world stealth game following the story of Big Boss.',
    imagePath: 'assets/images/metal_gear_solid_v.png',
    status: 'Next Up',
  ),
  Game(
    name: 'Deathloop',
    genre: 'Action FPS',
    description: 'Two rival assassins trapped in a time loop on a mysterious island.',
    imagePath: 'assets/images/deathloop.png',
    status: 'Next Up',
  ),
];

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2838),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171A21),
        title: const Text(
          'My Game Library',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.66,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return GestureDetector(
            onTap: () {
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      game.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  game.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: game.status == 'On Going'
                        ? const Color(0xFF4C6B22)
                        : const Color(0xFF2A475E),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    game.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}