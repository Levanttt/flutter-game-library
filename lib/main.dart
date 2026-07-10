import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/main_page.dart';
import 'screens/detail_page.dart';
import 'screens/avatar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider()..loadFromStorage(),
      child: MaterialApp(
        title: 'Game Library',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const MainPage(),
          '/detail': (context) => const DetailPage(),
          '/avatar': (context) => const AvatarPage(),
        },
      ),
    );
  }
}