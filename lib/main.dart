import 'package:flutter/material.dart';
import 'tela_login.dart';

void main() {
  runApp(const DiarioDeSaudeApp());
}

class DiarioDeSaudeApp extends StatelessWidget {
  const DiarioDeSaudeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Saúde',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Voltaire',
      ),
      home: const TelaLogin(),
    );
  }
}
