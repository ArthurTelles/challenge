import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B4DA7),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
              child: const Text('Teste'),
            ),
          ],
        ),
      ),
    );
  }
}
