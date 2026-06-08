import 'package:flutter/material.dart';
import 'detail_page.dart';

class Game {
  final String name;
  final String genre;
  final String description;
  final String imagePath;
  final String status;
  final int releaseYear;

  Game({
    required this.name,
    required this.genre,
    required this.description,
    required this.imagePath,
    required this.status,
    required this.releaseYear,
  });
}

final List<Game> games = [
  Game(
    name: 'The Witcher 3',
    genre: 'Action RPG',
    description: 'A story-driven open world RPG set in a visually stunning fantasy universe.',
    imagePath: 'assets/images/the_witcher_3.jpg',
    status: 'On Going',
    releaseYear: 2015,
  ),
  Game(
    name: 'Undertale',
    genre: 'RPG',
    description: 'A game where you dont have to kill anyone. Every monster can be spared.',
    imagePath: 'assets/images/undertale.png',
    status: 'On Going',
    releaseYear: 2015,
  ),
  Game(
    name: 'Metal Gear Solid V',
    genre: 'Stealth Action',
    description: 'An open world stealth game following the story of Big Boss.',
    imagePath: 'assets/images/metal_gear_solid_v.png',
    status: 'Next Up',
    releaseYear: 2015,
  ),
  Game(
    name: 'Deathloop',
    genre: 'Action FPS',
    description: 'Two rival assassins trapped in a time loop on a mysterious island.',
    imagePath: 'assets/images/deathloop.png',
    status: 'Next Up',
    releaseYear: 2021,
  ),
];

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final Map<String, bool> _expanded = {
    'On Going': true,
    'Next Up': true,
  };

  @override
  Widget build(BuildContext context) {
    final onGoing = games.where((g) => g.status == 'On Going').toList();
    final nextUp = games.where((g) => g.status == 'Next Up').toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1B2838),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171A21),
        title: const Text(
          'My Game Library',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildSection('On Going', onGoing),
          const SizedBox(height: 16),
          _buildSection('Next Up', nextUp),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Game> sectionGames) {
    final isExpanded = _expanded[title] ?? true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded[title] = !isExpanded;
            });
          },
          child: Row(
            children: [
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (isExpanded)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.66,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: sectionGames.length,
            itemBuilder: (context, index) {
              final game = sectionGames[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: game,
                  );
                },
                child: Card(
                  color: const Color(0xFF2A475E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          child: Image.asset(
                            game.imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            Text(
                              '${game.releaseYear}',
                              style: const TextStyle(
                                color: Color(0xFF8F98A0),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}