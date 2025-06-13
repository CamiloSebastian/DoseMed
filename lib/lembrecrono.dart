import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'tela_zinicial.dart';

class LembreCrono extends StatefulWidget {
  const LembreCrono({Key? key}) : super(key: key);

  @override
  State<LembreCrono> createState() => _LembreCronoState();
}

class _LembreCronoState extends State<LembreCrono> {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> deletarDocumento(String id, String colecao) async {
    await FirebaseFirestore.instance.collection(colecao).doc(id).delete();
  }

  Future<void> definirCronogramaAtivo(Map<String, dynamic> cronograma) async {
    if (userId == null) return;

    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .set({'cronogramaSelecionado': cronograma}, SetOptions(merge: true));
  }

  Widget buildItemTile(
    Map<String, dynamic> data,
    String id,
    String tipo, // 'lembretes' ou 'cronogramas'
  ) {
    return ListTile(
      title: Text(
        data['nome'] ?? 'Sem nome',
        style: const TextStyle(fontFamily: 'Voltaire', color: Color(0xFF734F50)),
      ),
      subtitle: tipo == 'lembretes'
          ? Text('Horário: ${data['horario'] ?? '---'}')
          : Text('Qtd/dia: ${data['qtd'] ?? '---'}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tipo == 'cronogramas')
            IconButton(
              icon: const Icon(Icons.check_circle, color: Color(0xFF734F50)),
              tooltip: 'Selecionar cronograma',
              onPressed: () async {
                await definirCronogramaAtivo(data);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cronograma selecionado!')),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await deletarDocumento(id, tipo);
            },
          ),
        ],
      ),
    );
  }

  Widget buildLista(String colecao) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(colecao)
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              colecao == 'lembretes'
                  ? 'Nenhum lembrete criado.'
                  : 'Nenhum cronograma criado.',
              style: const TextStyle(fontFamily: 'Voltaire', fontSize: 14),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return buildItemTile(data, doc.id, colecao);
          }).toList(),
        );
      },
    );
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
                'CRONOGRAMAS/LEMBRETES',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Voltaire',
                  fontSize: 20,
                  color: Color(0xFF734F50),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'LEMBRETES',
              style: TextStyle(fontFamily: 'Voltaire', fontSize: 16),
            ),
            buildLista('lembretes'),
            const SizedBox(height: 20),
            const Text(
              'CRONOGRAMAS',
              style: TextStyle(fontFamily: 'Voltaire', fontSize: 16),
            ),
            buildLista('cronogramas'),
            const Spacer(),
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
                    MaterialPageRoute(builder: (context) => const TelaZInicial()),
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
