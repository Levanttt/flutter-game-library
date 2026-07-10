import 'package:flutter/material.dart';

class AddGamePage extends StatelessWidget {
  const AddGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2838),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171A21),
        title: const Text(
          'Add Game',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text(
          'Add game coming soon',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}