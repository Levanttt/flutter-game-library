import 'package:flutter/material.dart';
import 'main_page.dart';
import 'list_page.dart';
import 'detail_page.dart';
import 'avatar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Library',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/detail': (context) => const DetailPage(),
        '/avatar': (context) => const AvatarPage(),
      },
    );
  }
}