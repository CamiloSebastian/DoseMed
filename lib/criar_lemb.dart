import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'tela_zinicial.dart';

class CriarLemb extends StatefulWidget {
  const CriarLemb({Key? key}) : super(key: key);

  @override
  State<CriarLemb> createState() => _CriarLembState();
}

class _CriarLembState extends State<CriarLemb> {
  final TextEditingController nomeController = TextEditingController();
  TimeOfDay? horarioSelecionado;

  Future<void> salvarLembrete() async {
    final String nome = nomeController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não autenticado')),
      );
      return;
    }
    if (nome.isEmpty || horarioSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos!')),
      );
      return;
    }

    final horarioFormatado =
        '${horarioSelecionado!.hour.toString().padLeft(2, '0')}:${horarioSelecionado!.minute.toString().padLeft(2, '0')}';

    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .collection('lembretes')
        .add({
      'nome': nome,
      'horario': horarioFormatado,
      'userId': user.uid,  // *** ESSENCIAL PARA FILTRAR ***
      'criadoEm': FieldValue.serverTimestamp(),
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: TextButton(
                onPressed: () async {
                  final TimeOfDay? escolhido = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (escolhido != null) {
                    setState(() {
                      horarioSelecionado = escolhido;
                    });
                  }
                },
                child: Text(
                  horarioSelecionado == null
                      ? 'Selecionar horário'
                      : '${horarioSelecionado!.hour.toString().padLeft(2, '0')}:${horarioSelecionado!.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontFamily: 'Voltaire',
                    fontSize: 16,
                    color: Color(0xFF734F50),
                  ),
                ),
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
                  await salvarLembrete();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaZInicial()),
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
