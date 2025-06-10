import 'package:firebase_core/firebase_core.dart';
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
      title: 'Diário de Saúde',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DellaRespira',
        scaffoldBackgroundColor: Color(0xffcb92ff), // lilás de fundo
      ),
      home: const TelaLogin(),
    );
  }
}
