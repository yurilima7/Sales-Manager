import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/botao_social.dart';
import 'package:sales_manager/components/botao_texto.dart';
import 'package:sales_manager/components/input.dart';
import 'package:sales_manager/screens/principal.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _email = TextEditingController();
  final _senha = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;

  void _proximaTela() async {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login realizado com sucesso!"),
        backgroundColor: Colors.greenAccent,
        duration: Duration(seconds: 1),
      )
    );

    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => const Principal()),
      (route) => false,
    );
  }

  _entrar() async {

    if(_email.text == '' && _senha.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Todos os campos vazios!"),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    } else if (_email.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("E-Mail inválido!"),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    } else if (_senha.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Senha inválida!"),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _senha.text,
      );

      userCredential.user!.updateDisplayName(_email.text);

      _proximaTela();

    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Este e-mail não está cadastrado!"),
            backgroundColor: Colors.redAccent,
          )
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sua senha está incorreta, tente novamente!"),
            backgroundColor: Colors.redAccent,
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
      
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              physics: const BouncingScrollPhysics(), // remove o sombreamento da scroll
              
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/sales manager.png',
                     width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  
                  const Text("SALES MANAGER", style: TextStyle(fontSize: 20, fontFamily: 'Audiowide-Regular', color: Color(0xFF6D3F8C))),
      
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  
                  const Text("Entre com", style: TextStyle(fontSize: 18, color: Color(0xFF734D8C))),
            
                 SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  const [
                      BotaoSocial(
                          titulo: "Google", google: true, caminho: "assets/icons/google.svg"),
                      BotaoSocial(
                          titulo: "Facebook", google: false, caminho: "assets/icons/facebook.svg"),
                      
                    ],
                  ),
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            
                  Input(label: "E-Mail", controller: _email), // input de inserção do e-mail
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
                  Input(
                      label: "Senha", senha: true, controller: _senha), // input de inserção da senha
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            
                  Botao(titulo: "Entrar", funcaoGeral: _entrar),
            
                  const BotaoTexto(
                      mensagem: "Não possui uma conta? Faça seu registro!",
                      proxima: '/criarConta',
                      tamanhoFonte: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}