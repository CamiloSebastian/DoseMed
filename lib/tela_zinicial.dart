import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tela_login.dart';
import 'lembrecrono.dart';
import 'criar_lemb.dart';
import 'criar_crono.dart';
import 'telaz_credito.dart';

class TelaZInicial extends StatefulWidget {
  const TelaZInicial({Key? key}) : super(key: key);

  @override
  State<TelaZInicial> createState() => _TelaZInicialState();
}

class _TelaZInicialState extends State<TelaZInicial> {
  final user = FirebaseAuth.instance.currentUser;
  int totalRegistros = 0;
  Map<String, dynamic>? cronogramaSelecionado;

  @override
  void initState() {
    super.initState();
    _carregarTotalRegistros();
    _carregarCronogramaSelecionado();
  }

  Future<void> _carregarTotalRegistros() async {
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('registros')
          .where('uid', isEqualTo: user!.uid)
          .get();

      setState(() {
        totalRegistros = snapshot.docs.length;
      });
    }
  }

  Future<void> _carregarCronogramaSelecionado() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user!.uid)
          .get();

      if (doc.exists && doc.data()?['cronogramaSelecionado'] != null) {
        setState(() {
          cronogramaSelecionado =
              Map<String, dynamic>.from(doc.data()!['cronogramaSelecionado']);
        });

        await verificarResetTomados();
      }
    }
  }

  Future<void> verificarResetTomados() async {
    if (user == null || cronogramaSelecionado == null) return;

    final hojeStr = DateTime.now().toIso8601String().substring(0, 10); // yyyy-MM-dd
    final ultimaAtualizacao = cronogramaSelecionado!['ultimaAtualizacao'] ?? '';

    if (hojeStr != ultimaAtualizacao) {
      // Resetar tomados para 0 e atualizar a data de atualização
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user!.uid)
          .update({
        'cronogramaSelecionado.tomados': 0,
        'cronogramaSelecionado.ultimaAtualizacao': hojeStr,
      });

      setState(() {
        cronogramaSelecionado = {
          ...cronogramaSelecionado!,
          'tomados': 0,
          'ultimaAtualizacao': hojeStr,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const rosaClaro = Color(0xFFF8C6C6);
    const roxoTexto = Color(0xFF4B3B4D);
    const corBola = Color(0xFFB07070);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: rosaClaro,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: corBola,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user?.displayName ?? 'Usuário',
                    style: const TextStyle(
                      fontFamily: 'Voltaire',
                      fontSize: 14,
                      color: roxoTexto,
                    ),
                  ),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(
                      fontFamily: 'Voltaire',
                      fontSize: 14,
                      color: roxoTexto,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
_DrawerItem(
  texto: 'CRÉDITOS',
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const TelaZCredito()),
    );
  },
),

            _DrawerItem(
              texto: 'DESLOGAR',
              onTap: () async {
                final confirmar = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Deseja sair?'),
                    content:
                        const Text('Tem certeza que deseja deslogar da sua conta?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Sair'),
                      ),
                    ],
                  ),
                );

                if (confirmar == true) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const TelaLogin()),
                  );
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: rosaClaro,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: rosaClaro,
              width: double.infinity,
              child: const Center(
                child: Text(
                  'DOSE MED',
                  style: TextStyle(
                    fontFamily: 'Voltaire',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (cronogramaSelecionado != null) ...[
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFFFF0F0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'CRONOGRAMA ATUAL:',
                      style: TextStyle(
                        fontFamily: 'Voltaire',
                        fontSize: 14,
                        color: Color(0xFF734F50),
                      ),
                    ),
                    Text(
                      '${cronogramaSelecionado!['nome']} (${cronogramaSelecionado!['tomados'] ?? 0}/${cronogramaSelecionado!['quantidadePorDia'] ?? 0} dia)',
                      style: const TextStyle(
                        fontFamily: 'Voltaire',
                        fontSize: 16,
                        color: Color(0xFF734F50),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),
            BotaoMenu(
              texto: 'TOMAR REMÉDIO',
              onPressed: () async {
                if (cronogramaSelecionado == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nenhum cronograma selecionado.')),
                  );
                  return;
                }

                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar dose?'),
                    content: Text(
                      'Deseja registrar uma dose para o cronograma "${cronogramaSelecionado!['nome']}"?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Confirmar'),
                      ),
                    ],
                  ),
                );

                if (confirm != true) return;

                final maxQtd = cronogramaSelecionado!['quantidadePorDia'] ?? 0;
                final atual = cronogramaSelecionado!['tomados'] ?? 0;

                if (atual >= maxQtd) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Você já tomou todas as doses hoje.')),
                  );
                  return;
                }

                final novoTomados = atual + 1;

                // Atualiza cronogramaSelecionado no Firestore
                await FirebaseFirestore.instance
                    .collection('usuarios')
                    .doc(user!.uid)
                    .update({
                  'cronogramaSelecionado.tomados': novoTomados,
                });

                // Adiciona registro
                await FirebaseFirestore.instance.collection('registros').add({
                  'uid': user!.uid,
                  'data': DateTime.now(),
                  'nomeCronograma': cronogramaSelecionado!['nome'],
                });

                // Atualiza localmente o estado
                setState(() {
                  cronogramaSelecionado = {
                    ...cronogramaSelecionado!,
                    'tomados': novoTomados,
                  };
                  totalRegistros += 1;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dose registrada com sucesso.')),
                );
              },
            ),

            const SizedBox(height: 16),
            BotaoMenu(
              texto: 'CRONOGRAMAS/LEMBRETES',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LembreCrono()),
                );
              },
            ),
            const SizedBox(height: 16),
            BotaoMenu(
              texto: 'CRIAR CRONOGRAMA',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CriarCrono()),
                );
              },
            ),
            const SizedBox(height: 16),
            BotaoMenu(
              texto: 'CRIAR LEMBRETE',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CriarLemb()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BotaoMenu extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const BotaoMenu({super.key, required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const roxoTexto = Color(0xFF4B3B4D);
    const rosaClaro = Color(0xFFF8C6C6);

    return SizedBox(
      width: 220,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: rosaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          texto,
          style: const TextStyle(
            fontFamily: 'Voltaire',
            fontSize: 16,
            color: roxoTexto,
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String texto;
  final VoidCallback onTap;

  const _DrawerItem({required this.texto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const roxoTexto = Color(0xFF4B3B4D);
    const corBola = Color(0xFFB07070);

    return ListTile(
      leading: const CircleAvatar(
        radius: 12,
        backgroundColor: corBola,
      ),
      title: Text(
        texto,
        style: const TextStyle(
          fontFamily: 'Voltaire',
          fontSize: 16,
          color: roxoTexto,
        ),
      ),
      onTap: onTap,
    );
  }
}
