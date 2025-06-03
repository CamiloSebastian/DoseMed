import 'package:flutter/material.dart';
import 'tela_zinicial.dart';


class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // Criar Conta
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaCriarController = TextEditingController();
  bool _aceitouTermos = false;

  bool _mostrarCriarConta = false;
  bool _mostrarTermos = false;

  final String _textoTermos = '''
Termos de Uso:

Ao utilizar este aplicativo/plataforma, você concorda com os seguintes termos e condições. ~
Este serviço tem como finalidade fornecer lembretes e metas relacionadas a práticas de bem-estar, incluindo, mas não se 
limitando a, ingestão de água, períodos de descanso, prática de exercícios físicos e horários de medicação. O uso contínuo 
do aplicativo constitui aceitação integral e irrestrita destes termos. O conteúdo disponibilizado possui caráter informativo 
e de apoio, não devendo ser interpretado como aconselhamento médico, diagnóstico ou tratamento. Recomendamos sempre a consulta
com profissionais da saúde habilitados para orientações específicas. O usuário reconhece que é inteiramente responsável pelas
informações fornecidas, pela configuração de lembretes e pelo uso adequado do aplicativo. O Diário de Saúde não se responsabiliza
por atrasos, falhas técnicas, esquecimentos, ou eventuais danos decorrentes do uso ou da incapacidade de uso da plataforma. 
Reservamo-nos o direito de modificar, suspender ou descontinuar, a qualquer momento e sem aviso prévio, qualquer funcionalidade
ou aspecto do serviço. Também poderemos alterar estes termos a qualquer momento. O uso contínuo após qualquer modificação será
considerado aceitação dos novos termos. Ao continuar, você declara que leu, compreendeu e concorda com estes Termos de Uso.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      body: Center(
        child: Container(
          width: 480,
          height: 700,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black),
          ),
          child: Stack(
            children: [
              _mostrarCriarConta ? _buildCriarConta(context) : _buildLogin(context),
              if (_mostrarTermos) _buildTermosDialog(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Diário de Saúde',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Cinzel Decorative',
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        Image.asset(
          'assets/images/bemestar.png',
          width: 120,
          height: 120,
        ),
        TextField(
          controller: _usuarioController,
          decoration: const InputDecoration(
            labelText: 'Usuário',
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(fontFamily: 'Della Respira'),
        ),
        TextField(
          controller: _senhaController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Senha',
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(fontFamily: 'Della Respira'),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaInicial()),
    );
  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
            ),
            child: const Text(
              'ENTRAR',
              style: TextStyle(
                fontFamily: 'Della Respira',
                fontSize: 18,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _mostrarCriarConta = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
            ),
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(
                fontFamily: 'Della Respira',
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCriarConta(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'CRIAR CONTA',
          style: TextStyle(
            fontFamily: 'Cinzel Decorative',
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        TextField(
          controller: _nomeController,
          decoration: const InputDecoration(
            labelText: 'Nome',
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(fontFamily: 'Della Respira'),
        ),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(fontFamily: 'Della Respira'),
        ),
        TextField(
          controller: _senhaCriarController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Senha',
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(fontFamily: 'Della Respira'),
        ),
        Row(
          children: [
            Checkbox(
              value: _aceitouTermos,
              onChanged: (value) {
                setState(() {
                  _aceitouTermos = value ?? false;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _mostrarTermos = true;
                });
              },
              child: const Text(
                'Aceito os Termos de Uso',
                style: TextStyle(
                  fontFamily: 'Della Respira',
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _aceitouTermos
                  ? () {
                      setState(() {
                        _mostrarCriarConta = false;
                      });
                      // Aqui colocaria lógica para criar conta
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
              child: const Text(
                'CONFIRMAR',
                style: TextStyle(
                  fontFamily: 'Della Respira',
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _mostrarCriarConta = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
              child: const Text(
                'CANCELAR',
                style: TextStyle(
                  fontFamily: 'Della Respira',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTermosDialog(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: [
            const Text(
              'Termos de Uso',
              style: TextStyle(
                fontFamily: 'Cinzel Decorative',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _textoTermos,
                  style: const TextStyle(fontFamily: 'Della Respira'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _mostrarTermos = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
              child: const Text(
                'FECHAR',
                style: TextStyle(
                  fontFamily: 'Della Respira',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
