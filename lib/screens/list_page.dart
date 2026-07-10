import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/game_provider.dart';

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
    final gameProvider = context.watch<GameProvider>();
    final onGoing = gameProvider.onGoing;
    final nextUp = gameProvider.nextUp;

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
          onTap: () => setState(() => _expanded[title] = !isExpanded),
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
                  Navigator.pushNamed(context, '/detail', arguments: game);
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
                          // Game dari Steam pakai URL (Image.network),
                          // game input manual pakai asset lokal (Image.asset)
                          child: game.isNetworkImage
                              ? Image.network(
                            game.imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                              : Image.asset(
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