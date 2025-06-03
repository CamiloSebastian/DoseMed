import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool _mostrarConfirmacaoSaida = false;

  void _confirmarSaida() {
    setState(() {
      _mostrarConfirmacaoSaida = true;
    });
  }

  void _sair() {
    // Aqui você pode colocar a lógica para sair do app ou voltar para o login
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 380,
              height: 600,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'DIÁRIO DE SAÚDE',
                    style: TextStyle(
                      fontFamily: 'Cinzel Decorative',
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  Image.asset(
                    'assets/images/saude.png',
                    width: 120,
                    height: 120,
                  ),
                  _buildBotao('MONITORAR HIDRATAÇÃO'),
                  _buildBotao('MONITORAR MEDICAÇÃO'),
                  _buildBotao('MONITORAR EXERCÍCIO'),
                  _buildBotao('MONITORAR DESCANSO'),
                  ElevatedButton(
                    onPressed: _confirmarSaida,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Text(
                      'SAIR',
                      style: TextStyle(
                        fontFamily: 'Della Respira',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Text(
                    'Criado por:\n'
                    'Camilo Sebastian Lopes Miranda\n'
                    'Niemias Vidal Medeiros\n'
                    'Kleiton Santana de Jesus\n'
                    'Gabriel Fernandes Marques dos Santos\n'
                    'Luan Orlando Carvalho Lima',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Della Respira',
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (_mostrarConfirmacaoSaida) _buildConfirmacaoSaida(),
          ],
        ),
      ),
    );
  }

  Widget _buildBotao(String texto) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Aqui pode colocar navegação para as telas de monitoramento
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black),
          ),
        ),
        child: Text(
          texto,
          style: const TextStyle(
            fontFamily: 'Della Respira',
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmacaoSaida() {
    return Container(
      width: 300,
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'DESEJA REALMENTE SAIR?',
            style: TextStyle(
              fontFamily: 'Cinzel Decorative',
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: _sair,
                child: const Text(
                  'SIM',
                  style: TextStyle(
                    fontFamily: 'Della Respira',
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Image.asset(
                'assets/images/saude.png',
                width: 40,
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _mostrarConfirmacaoSaida = false;
                  });
                },
                child: const Text(
                  'NÃO',
                  style: TextStyle(
                    fontFamily: 'Della Respira',
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
