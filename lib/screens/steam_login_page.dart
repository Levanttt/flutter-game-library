import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SteamLoginPage extends StatefulWidget {
  const SteamLoginPage({super.key});

  @override
  State<SteamLoginPage> createState() => _SteamLoginPageState();
}

class _SteamLoginPageState extends State<SteamLoginPage> {
  static const _loginUrl =
      'https://steam-backend.luthfiardi66.workers.dev/auth/steam';
  static const _callbackScheme = 'gamelibrary://auth-callback';

  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onNavigationRequest: (request) {
            if (request.url.startsWith(_callbackScheme)) {
              final uri = Uri.parse(request.url);
              final steamId = uri.queryParameters['steamid'];
              Navigator.pop(context, steamId);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_loginUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2838),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171A21),
        title: const Text(
          'Login dengan Steam',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}