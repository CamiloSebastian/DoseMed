import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'tela_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
