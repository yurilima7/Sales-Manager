import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/widgets/botao.dart';
import 'package:sales_manager/widgets/botao_texto.dart';
import 'package:sales_manager/widgets/input.dart';
import 'package:sales_manager/screens/login.dart';
import 'package:sales_manager/util/autenticacao.dart';
import 'package:sales_manager/util/mensagens.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  State<CriarConta> createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {

  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _usuario = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;

  void _proximaTela() async {

    Mensagens().mensagemCronometrada("Cadastrado com sucesso!", false, context);

    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const Login()),
        (route) => false,
      );
    }); 
  }

  _registrar() async{

    if(_email.text == '' && _senha.text == '' && _usuario.text == ''){
      Mensagens().mensagem("Todos os campos vazios!", true, context);

      return;
    } else if (_email.text == '') {
      Mensagens().mensagem("E-Mail inválido!", true, context);

      return;
    } else if (_senha.text == '') {
      Mensagens().mensagem("Senha inválida!", true, context);

      return;
    } else if (_usuario.text == '') {
      Mensagens().mensagem("Usuário inválido!", true, context);

      return;
    }

    User? usuario = await Autenticacao.criarConta(
      context: context, 
      email: _email.text, 
      senha: _senha.text, 
      usuario: _usuario.text,
    );
    
    if(usuario != null){
      _proximaTela();
    }
    
  }

  @override
  void dispose(){
    _email.dispose();
    _senha.dispose();
    _usuario.dispose();
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
                  
                  const Text("Cadastre-se", style: TextStyle(fontSize: 18, color: Color(0xFF734D8C))),
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            
                  Input(label: "Usuário", hint: "Digite seu nome de usuário", usuario: true, controller: _usuario),
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
                  Input(label: "E-Mail", hint: "Digite seu e-mail", controller: _email), // input de inserção do e-mail
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
                  Input(
                      label: "Senha", hint: "Digite sua senha",senha: true, controller: _senha), // input de inserção da senha
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            
                  Botao(titulo: "Registrar", funcaoGeral: _registrar),
                 
                  const BotaoTexto(
                      mensagem: "Possui uma conta? Faça login!", 
                      proxima: '/login',
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