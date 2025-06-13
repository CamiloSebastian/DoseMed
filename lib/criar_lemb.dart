import 'package:flutter/material.dart';
import 'tela_zinicial.dart';

class CriarLemb extends StatelessWidget {
  const CriarLemb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController horarioController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFFFE5E5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFFFB8B8),
              child: const Text(
                'CRIAR LEMBRETE DIÁRIO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Voltaire',
                  fontSize: 20,
                  color: Color(0xFF734F50),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'NOME DO LEMBRETE:',
              style: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 14,
                color: Color(0xFF734F50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: TextField(
                controller: nomeController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'HORÁRIO DO LEMBRETE:',
              style: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 14,
                color: Color(0xFF734F50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: TextField(
                controller: horarioController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
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
                child: const Text('CONFIRMAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
