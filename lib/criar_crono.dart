import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tela_zinicial.dart';

class CriarCrono extends StatelessWidget {
  const CriarCrono({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController qtdController = TextEditingController();

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
                'CRIAR CRONOGRAMA DIÁRIO',
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
              'NOME DO CRONOGRAMA:',
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
              'REMÉDIOS POR DIA',
              style: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 14,
                color: Color(0xFF734F50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: TextField(
                controller: qtdController,
                keyboardType: TextInputType.number,
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
                onPressed: () async {
                  final String nome = nomeController.text.trim();
                  final String qtd = qtdController.text.trim();

                  if (nome.isEmpty || qtd.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preencha todos os campos!')),
                    );
                    return;
                  }

                  final int? quantidade = int.tryParse(qtd);
                  if (quantidade == null || quantidade <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Quantidade deve ser um número positivo')),
                    );
                    return;
                  }

                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await FirebaseFirestore.instance
                        .collection('usuarios')
                        .doc(user.uid)
                        .collection('cronogramas')
                        .add({
                      'nome': nome,
                      'quantidadePorDia': quantidade,
                      'tomados': 0,
                      'createdAt': FieldValue.serverTimestamp(),
                    });

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaZInicial()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Usuário não autenticado')),
                    );
                  }
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
