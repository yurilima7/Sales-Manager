import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/botao_social.dart';
import 'package:sales_manager/components/botao_texto.dart';
import 'package:sales_manager/components/input.dart';
import 'package:sales_manager/screens/login.dart';

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
  final db = FirebaseFirestore.instance;

  void _proximaTela() async {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cadastrado com sucesso!"),
        backgroundColor: Colors.greenAccent,
        duration: Duration(seconds: 1),
      )
    );

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
    } else if (_usuario.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuário inválido!"),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    }
    
    try {

      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: _email.text, password: _senha.text); // cadastrando usuário

      userCredential.user!.updateDisplayName(_usuario.text);

      db.collection("Usuários").doc(userCredential.user!.uid).set({ // adicionando informações do usuário no banco de dados
        "Usuário": _usuario.text,
        "Lucro": 0.0,
        "A Receber": 0.0,
        "Vendido": 0.0,
        "Quantidade de Vendas": 0,
        "Valores Deletados": 0.0
      });
     
      _proximaTela();

    } on FirebaseAuthException catch (e) {

      if(e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Senha não aceita, crie uma mais forte!"),
            backgroundColor: Colors.redAccent,
          )
        );

      }else if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Este e-mail já está cadastrado!"),
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
                  
                  const Text("Cadastre-se com", style: TextStyle(fontSize: 18, color: Color(0xFF734D8C))),
            
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