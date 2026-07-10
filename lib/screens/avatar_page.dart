import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePath = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF171A21),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Cover Art',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(48),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A475E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  'Kembali ke Daftar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}