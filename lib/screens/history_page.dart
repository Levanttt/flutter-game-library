import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2838),
      body: const Center(
        child: Text(
          'History coming soon',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}