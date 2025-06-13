import 'package:flutter/material.dart';
import 'tela_zinicial.dart';

class LembreCrono extends StatelessWidget {
  const LembreCrono({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFFFB8B8),
              child: Text(
                'CRONOGRAMAS/LEMBRETES',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Voltaire',
                  fontSize: 20,
                  color: Color(0xFF734F50),
                ),
              ),
            ),
            Expanded(
              child: Container(), // Espaço vazio branco
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB8B8),
                  foregroundColor: const Color(0xFF734F50),
                  textStyle: const TextStyle(
                    fontFamily: 'Voltaire',
                    fontSize: 16,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TelaZInicial()),
                  );
                },
                child: const Text('VOLTAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
