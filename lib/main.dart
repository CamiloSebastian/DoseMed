import 'package:flutter/material.dart';
import 'tela_login.dart';

void main() {
  runApp(const DoseMedApp());
}

class DoseMedApp extends StatelessWidget {
  const DoseMedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dose Med',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Voltaire',
      ),
      home: const TelaLogin(),
    );
  }
}
