import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'admin' && password == '1234') {
      final service = PreferencesService();
      await service.setLoggedIn(true);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau password salah')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2838),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo/logo.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 0),
              const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Color(0xFF8F98A0)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2A475E)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xFF8F98A0)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2A475E)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C6B22),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _login,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}