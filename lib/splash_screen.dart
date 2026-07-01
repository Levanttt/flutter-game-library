import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import 'login_screen.dart';
import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkNavigation();
  }

  Future<void> _checkNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('is_first_launch') ?? true;
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (isFirstLaunch) {
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2838),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_esports,
              color: Colors.white,
              size: 80,
            ),
            SizedBox(height: 16),
            Text(
              'Game Library',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}