import 'package:flutter/material.dart';
import 'tela_login.dart';
import 'lembrecrono.dart';
import 'criar_lemb.dart';
import 'criar_crono.dart';

class TelaZInicial extends StatelessWidget {
  const TelaZInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rosaClaro = Color(0xFFF8C6C6);
    const roxoTexto = Color(0xFF4B3B4D);
    const corBola = Color(0xFFB07070); // mesma cor dos ícones

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
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: corBola,
                    child: Text(
                      'L',
                      style: TextStyle(
                        fontFamily: 'Voltaire',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'nickdocriarconta',
                    style: TextStyle(
                      fontFamily: 'Voltaire',
                      fontSize: 14,
                      color: roxoTexto,
                    ),
                  ),
                  Text(
                    'gmaildaqueapessoaefezlogin',
                    style: TextStyle(
                      fontFamily: 'Voltaire',
                      fontSize: 14,
                      color: roxoTexto,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DrawerItem(texto: 'PERFIL', onTap: () {}),
            _DrawerItem(texto: 'CRÉDITOS', onTap: () {}),
            _DrawerItem(texto: 'CONFIGURAÇÕES', onTap: () {}),
            _DrawerItem(
              texto: 'DESLOGAR',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => _ConfirmarSaidaDialog(context),
                );
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/coracao.png',
                    height: 50,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'REMÉDIOS TOMADOS\n0/10',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Voltaire',
                      fontSize: 16,
                      color: roxoTexto,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            BotaoMenu(texto: 'TOMAR REMÉDIO', onPressed: () {}),
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

  // Diálogo personalizado
  Widget _ConfirmarSaidaDialog(BuildContext context) {
    const rosaClaro = Color(0xFFF8C6C6);
    const roxoTexto = Color(0xFF4B3B4D);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.all(16),
        color: rosaClaro,
        child: const Text(
          'DESEJA REALMENTE SAIR?',
          style: TextStyle(
            fontFamily: 'Voltaire',
            fontSize: 18,
            color: roxoTexto,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const TelaLogin()),
              );
            },
            child: const Text(
              'SIM',
              style: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 18,
                color: roxoTexto,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha apenas o diálogo
            },
            child: const Text(
              'NÃO',
              style: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 18,
                color: roxoTexto,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BotaoMenu extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const BotaoMenu({
    super.key,
    required this.texto,
    required this.onPressed,
  });

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
