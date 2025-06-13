import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaZCredito extends StatelessWidget {
  const TelaZCredito({super.key});

  // Função auxiliar para abrir links
  void _abrirLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    const roxoTexto = Color(0xFF4B3B4D);
    const rosaClaro = Color(0xFFF8C6C6);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: rosaClaro,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'CRÉDITOS',
          style: TextStyle(
            fontFamily: 'Voltaire',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Equipe de Desenvolvedores:',
              style: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 18,
                color: roxoTexto,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('✦ Camilo Sebastian Lopes Miranda', style: _textoCredito),
            const Text('✦ Neemias Vidal Medeiros', style: _textoCredito),
            const Text('✦ Kleiton Santana de Jesus', style: _textoCredito),
            const Text('✦ Gabriel Fernandes Marques dos Santos', style: _textoCredito),
            const Text('✦ Luan Orlando Carvalho Lima', style: _textoCredito),

            const SizedBox(height: 24),
            const Text(
              'Designers:',
              style: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 18,
                color: roxoTexto,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('✦ Camilo Sebastian Lopes Miranda', style: _textoCredito),
            const Text('✦ Neemias Vidal Medeiros', style: _textoCredito),

            const SizedBox(height: 24),
            const Text(
              'Ilustrações:',
              style: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 18,
                color: roxoTexto,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '✦ Freepik - Profissionais de Saúde (pikisuperstar):',
              style: _textoCredito,
            ),
            GestureDetector(
              onTap: () => _abrirLink(
                'https://br.freepik.com/vetores-gratis/profissionais-de-saude-de-desenhos-animados_13404333.htm',
              ),
              child: const Text(
                'Link da ilustração',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontFamily: 'Voltaire',
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _abrirLink('https://br.freepik.com/autor/pikisuperstar'),
              child: const Text(
                'Perfil do autor (pikisuperstar)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontFamily: 'Voltaire',
                ),
              ),
            ),

            const SizedBox(height: 32),
            const Center(
              child: Text(
                'OBRIGADO POR USAR O APP',
                style: TextStyle(
                  fontFamily: 'Voltaire',
                  fontSize: 18,
                  color: roxoTexto,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const TextStyle _textoCredito = TextStyle(
  fontSize: 14,
  fontFamily: 'Voltaire',
  color: Color(0xFF4B3B4D),
);
