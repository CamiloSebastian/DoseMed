import 'package:flutter/material.dart';
import 'tela_login.dart';

void main() {
  runApp(const DiarioSaudeApp());
}

class DiarioSaudeApp extends StatelessWidget {
  const DiarioSaudeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Saúde ',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color(0xFFE1BEE7),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Serif', fontSize: 16),
        ),
      ),
      home: const TelaLogin(),
    );
  }
}
