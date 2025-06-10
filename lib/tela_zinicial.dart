import 'package:flutter/material.dart';
import 'tela_login.dart'; // Certifique-se de importar corretamente

class TelaZInicial extends StatelessWidget {
  const TelaZInicial({super.key});

  void _mostrarConfirmacaoLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD9AFFF),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                child: Text(
                  "DESEJA REALMENTE SAIR?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'CinzelDecorative',
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Image.asset('assets/images/saude.png', height: 60),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => TelaLogin()),
                        (route) => false,
                      );
                    },
                    child: const Text("SIM",
                        style: TextStyle(
                            fontFamily: 'Vollkorn',
                            fontSize: 16,
                            color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("NÃO",
                        style: TextStyle(
                            fontFamily: 'Vollkorn',
                            fontSize: 16,
                            color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botao(String texto, {VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF0C8FF),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        ),
        onPressed: onPressed,
        child: Text(
          texto,
          style: const TextStyle(
            fontFamily: 'Vollkorn',
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F4F7),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Color(0xFFD9AFFF),
              child: Column(
                children: [
                  const Text(
                    "DIÁRIO DE SAÚDE",
                    style: TextStyle(
                      fontFamily: 'CinzelDecorative',
                      fontSize: 22,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Image.asset('assets/images/saude.png', height: 70),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _botao("MONITORAR HIDRATAÇÃO"),
            _botao("MONITORAR MEDICAÇÃO"),
            _botao("MONITORAR EXERCÍCIO"),
            _botao("MONITORAR DESCANSO"),
            _botao("SLA"),
            _botao("CRÉDITOS"),
            _botao("PERFIL"),
            _botao("DESLOGAR",
                onPressed: () => _mostrarConfirmacaoLogout(context)),
          ],
        ),
      ),
    );
  }
}
