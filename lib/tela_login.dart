import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tela_zinicial.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  int modo = 0; // 0: início, 1: login, 2: criar conta

  final Color rosa = const Color(0xFFFFB8B8);
  final Color marrom = const Color(0xFF734444);

  bool termosAceitos = false;

  // Controladores
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  void mostrarTermosUso() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: rosa,
        title: const Text(
          'TERMOS DE USO',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF734444),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            '''Ao utilizar este aplicativo, você concorda com os seguintes termos: 
Este serviço tem como objetivo oferecer lembretes e metas voltadas ao bem-estar, como ingestão de água, descanso, exercícios físicos e horários de medicação. 
O uso contínuo do aplicativo representa sua aceitação total destes termos. O conteúdo fornecido tem caráter apenas informativo e de apoio, e não deve ser considerado 
como orientação médica, diagnóstico ou tratamento. Recomendamos sempre buscar a orientação de profissionais de saúde qualificados. Você é responsável pelas informações 
inseridas, pela configuração dos lembretes e pelo uso adequado do aplicativo. O Diário de Saúde não se responsabiliza por atrasos, falhas técnicas, esquecimentos ou quaisquer 
danos decorrentes do uso ou da impossibilidade de uso da plataforma. Podemos, a qualquer momento e sem aviso prévio, modificar, suspender ou encerrar funcionalidades do serviço, bem como 
alterar estes termos. O uso contínuo após alterações será considerado aceitação dos novos termos. Ao seguir utilizando o aplicativo, você declara que leu, compreendeu e concorda com estes Termos de Uso.''',
            style: TextStyle(color: marrom),
            textAlign: TextAlign.justify,
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'FECHAR',
                style: TextStyle(color: Color(0xFF734444)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInicio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'DOSE MED',
          style: TextStyle(
            fontSize: 29,
            color: Color(0xFF734444),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset('assets/images/medasiatCORT.png', height: 200),
        const SizedBox(height: 24),
        const Text(
          'Dose Med, sua rotina de saúde, no tempo certo',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Color(0xFF734444)),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () => setState(() => modo = 1),
          style: estiloBotao(),
          child: const Text('LOGIN'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() => modo = 2),
          style: estiloBotao(),
          child: const Text('CRIAR CONTA'),
        ),
      ],
    );
  }

  Widget buildLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/medasiatCORT.png', height: 220),
        const SizedBox(height: 24),
        campoTexto('COLOQUE SEU EMAIL:', emailController),
        const SizedBox(height: 16),
        campoTexto('COLOQUE SUA SENHA', senhaController, isSenha: true),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () async {
            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: senhaController.text,
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TelaZInicial()),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao fazer login: ${e.toString()}')),
              );
            }
          },
          style: estiloBotao(),
          child: const Text('CONFIRMAR'),
        ),
      ],
    );
  }

  Widget buildCriarConta() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        campoTexto('COLOQUE SEU EMAIL:', emailController),
        const SizedBox(height: 12),
        campoTexto('CRIE UM NOME:', nomeController),
        const SizedBox(height: 12),
        campoTexto('CRIE UMA SENHA', senhaController, isSenha: true),
        const SizedBox(height: 12),
        campoTexto('CONFIRME SUA SENHA', confirmarSenhaController, isSenha: true),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: termosAceitos,
              onChanged: (val) => setState(() => termosAceitos = val ?? false),
              activeColor: marrom,
            ),
            GestureDetector(
              onTap: mostrarTermosUso,
              child: const Text(
                'ACEITO OS TERMOS DE USO',
                style: TextStyle(color: Color(0xFF734444)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () async {
            if (!termosAceitos) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Você precisa aceitar os termos de uso')),
              );
              return;
            }

            final email = emailController.text.trim();
            final senha = senhaController.text;
            final confirmar = confirmarSenhaController.text;

            if (senha != confirmar) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('As senhas não coincidem')),
              );
              return;
            }

            try {
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: senha,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Conta criada com sucesso!')),
              );

              setState(() {
                modo = 0; // Volta pra tela inicial
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro: ${e.toString()}')),
              );
            }
          },
          style: estiloBotao(),
          child: const Text('CONFIRMAR'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget conteudo;
    if (modo == 1) {
      conteudo = buildLogin();
    } else if (modo == 2) {
      conteudo = buildCriarConta();
    } else {
      conteudo = buildInicio();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFB8B8),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: conteudo,
          ),
        ),
      ),
    );
  }

  TextField campoTexto(String label, TextEditingController controller, {bool isSenha = false}) {
    return TextField(
      controller: controller,
      obscureText: isSenha,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF734444), fontSize: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      style: const TextStyle(color: Color(0xFF734444)),
    );
  }

  ButtonStyle estiloBotao() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF734444),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: const Size(double.infinity, 48),
    );
  }
}
