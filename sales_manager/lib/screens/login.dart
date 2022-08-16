import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/botao_social.dart';
import 'package:sales_manager/components/botao_texto.dart';
import 'package:sales_manager/components/input.dart';
import 'package:sales_manager/screens/tap_bar_telas.dart';
import 'package:sales_manager/util/autenticacao.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _email = TextEditingController();
  final _senha = TextEditingController();

  void _proximaTela() async {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login realizado com sucesso!"),
        backgroundColor: Colors.greenAccent,
        duration: Duration(seconds: 1),
      )
    );

    await Future.delayed(const Duration(milliseconds: 1500), (() {
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const PercorreTelas()),
        (route) => false,
      );
    }));  
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

    User? usuario = await Autenticacao.loginEmail(
      context: context, 
      email: _email.text, 
      senha: _senha.text,
    );

    if(usuario != null){
      _proximaTela();
    }
  }

  _loginGoogle() async{
    User? usuario = await Autenticacao.registrarGoogle(context: context);

    if(usuario != null){
      _proximaTela();
    }
  }

  _loginFacebook() async{
    User? usuario = await Autenticacao.registrarFacebook(context: context);
    
    if(usuario != null){
      _proximaTela();
    }
  }

   @override
  void dispose(){
    _email.dispose();
    _senha.dispose();
    super.dispose();
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
                    children: [
                      BotaoSocial(
                          titulo: "Google", google: true, caminho: "assets/icons/google.svg", loginSocial: _loginGoogle),
                      BotaoSocial(
                          titulo: "Facebook", google: false, caminho: "assets/icons/facebook.svg", loginSocial: _loginFacebook),
                      
                    ],
                  ),
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            
                  Input(label: "E-Mail", hint: "Digite seu e-mail", controller: _email), // input de inserção do e-mail
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
                  Input(
                      label: "Senha", hint: "Digite sua senha", senha: true, controller: _senha), // input de inserção da senha
            
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