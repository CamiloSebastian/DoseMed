import 'package:flutter/material.dart';
import 'tela_zinicial.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  void _abrirCriarConta() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFFEEDCFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: CriarContaWidget(onVoltar: () => Navigator.pop(context)),
      ),
    );
  }

  void _abrirLogin() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFFEEDCFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const LoginWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'DIÁRIO DE SAÚDE',
                style: const TextStyle(
                  fontFamily: 'CinzelDecorative',
                  fontSize: 24,
                  color: Color(0xff574a5e),
                  backgroundColor: Color(0xFFD9A9FF),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/images/medasiatCORT.png', height: 200),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Diário de Saúde, venha monitorar sua vida de uma forma simples e prática',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Vollkorn',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _abrirLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text('LOGIN'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _abrirCriarConta,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                ),
                child: const Text('CRIAR CONTA'),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Criado por:\nCamilo Sebastian Lopes Miranda\nNeemias Vidal Medeiros\nKleiton Santana de Jesus\nGabriel Fernandes Marques dos Santos\nLuan Orlando Carvalho Lima',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontFamily: 'Vollkorn'),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/bemestar.png', height: 60),
        const SizedBox(height: 10),
        const Text("COLOQUE SEU EMAIL:",
            style: TextStyle(fontFamily: 'Vollkorn')),
        const TextField(),
        const SizedBox(height: 10),
        const Text("COLOQUE SUA SENHA",
            style: TextStyle(fontFamily: 'Vollkorn')),
        const TextField(obscureText: true),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o diálogo de login
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => TelaZInicial()),
            );
          },
          child: const Text("CONFIRMAR"),
        ),
      ],
    );
  }
}

class CriarContaWidget extends StatefulWidget {
  final VoidCallback onVoltar;

  const CriarContaWidget({required this.onVoltar, super.key});

  @override
  State<CriarContaWidget> createState() => _CriarContaWidgetState();
}

class _CriarContaWidgetState extends State<CriarContaWidget> {
  bool aceitarTermos = false;

  void _mostrarTermos() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFFEEDCFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const TermosDeUsoWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/bemestar.png', height: 60),
          const SizedBox(height: 10),
          const Text("COLOQUE SEU EMAIL:",
              style: TextStyle(fontFamily: 'Vollkorn')),
          const TextField(),
          const SizedBox(height: 10),
          const Text("CRIE UMA SENHA",
              style: TextStyle(fontFamily: 'Vollkorn')),
          const TextField(obscureText: true),
          const SizedBox(height: 10),
          const Text("CONFIRME SUA SENHA",
              style: TextStyle(fontFamily: 'Vollkorn')),
          const TextField(obscureText: true),
          Row(
            children: [
              Checkbox(
                value: aceitarTermos,
                onChanged: (value) {
                  setState(() {
                    aceitarTermos = value!;
                  });
                },
              ),
              const Text("ACEITO OS TERMOS DE USO",
                  style: TextStyle(fontFamily: 'Vollkorn')),
              TextButton(
                onPressed: _mostrarTermos,
                child: const Text("Ver"),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: aceitarTermos ? () => Navigator.pop(context) : null,
            child: const Text("CONFIRMAR"),
          ),
        ],
      ),
    );
  }
}

class TermosDeUsoWidget extends StatelessWidget {
  const TermosDeUsoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Text(
            "TERMOS DE USO",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Vollkorn'),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              """Ao utilizar este aplicativo/plataforma, você concorda com os seguintes termos e condições. Este serviço tem como finalidade fornecer lembretes e metas relacionadas a práticas de bem-estar, incluindo, mas não se limitando a, ingestão de água, períodos de descanso, prática de exercícios físicos e horários de medicação. O uso contínuo do aplicativo constitui aceitação integral e irrestrita destes termos. O conteúdo disponibilizado possui caráter informativo e de apoio, não devendo ser interpretado como aconselhamento médico, diagnóstico ou tratamento. Recomendamos sempre a consulta com profissionais da saúde habilitados para orientações específicas. O usuário reconhece que é inteiramente responsável pelas informações fornecidas, pela configuração de lembretes e pelo uso adequado do aplicativo. O Diário de Saúde não se responsabiliza por atrasos, falhas técnicas, esquecimentos, ou eventuais danos decorrentes do uso ou da incapacidade de uso da plataforma. Reservamo-nos o direito de modificar, suspender ou descontinuar, a qualquer momento e sem aviso prévio, qualquer funcionalidade ou aspecto do serviço. Também poderemos alterar estes termos a qualquer momento. O uso contínuo após qualquer modificação será considerado aceitação dos novos termos. Ao continuar, você declara que leu, compreendeu e concorda com estes Termos de Uso.""",
              textAlign: TextAlign.justify,
              style: TextStyle(fontFamily: 'Vollkorn'),
            ),
          ),
        ],
      ),
    );
  }
}
