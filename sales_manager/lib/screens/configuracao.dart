import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/screens/editar_perfil.dart';
import 'package:sales_manager/screens/estado_usuario.dart';
import 'package:sales_manager/widgets/tap_bar_telas.dart';
import 'package:sales_manager/util/autenticacao.dart';
import 'package:sales_manager/util/mensagens.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({Key? key}) : super(key: key);

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {

  late String _nomeUsuario = "";

  final db = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário
  var usuario = FirebaseAuth.instance.currentUser;

  @override
  initState() {
    super.initState();
    _recebeUsuario();
  }

  _recebeUsuario() async {
    late String nome;

    await db.collection("Usuários").doc(usuarioID.toString()).get().then((doc) => {
      if(doc.exists){
        nome = doc.data()!["Usuário"],
      }
    },);

    setState(() {
      _nomeUsuario = nome;
    });
  } 

  _proximaTela(String mensagem) async {

    Mensagens().mensagem(mensagem, false, context);

    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const EstadoUsuario()),
        (route) => false,
      );
    }); 
  }

  _sair() async {
    Autenticacao.signOut(context: context);    
    _proximaTela("Logout realizado com sucesso!");
  }

  _apagaClientes() async{
    // deleta todos os clientes do banco
    await db.collection("Usuários").doc(usuarioID).collection("Clientes")
    .get().then((QuerySnapshot querySnapshot) => {

        for (var doc in querySnapshot.docs){
          // deleta todas as compras existentes de todos os clientes
          db.collection("Usuários").doc(usuarioID).collection("Clientes")
          .doc(doc.id).collection("Produtos").get().then((QuerySnapshot querySnapshot2) => {

            for(var doc2 in querySnapshot2.docs){
              doc2.reference.delete(),
            }
          }),

          doc.reference.delete(),
        },
      }
    );

    // deleta as últimas vendas
    await db.collection("Usuários").doc(usuarioID).collection("Últimas Vendas")
    .get().then((QuerySnapshot querySnapshot) => {

        for (var doc in querySnapshot.docs){
          doc.reference.delete(),
        },
      }
    );
  }

  _reiniciaUsuario() async {
    // reinicia os dados do usuário
    await db.collection("Usuários").doc(usuarioID).update({
      "Lucro": 0.0,
      "A Receber": 0.0,
      "Vendido": 0.0,
      "Quantidade de Vendas": 0,
      "Valores Deletados": 0.0
    });
  }

  _restaurar() {

    _apagaClientes();
    _reiniciaUsuario();

    Mensagens().mensagem("Dados restaurados com sucesso!", false, context);
  }

  _encerraConta() async{

    _apagaClientes();

    // deleta todos os dados do usuário no banco
    await db.collection("Usuários").doc(usuarioID).delete().then(
      (doc) {
        usuario?.delete().then(
          (doc2) {
            Autenticacao.signOut(context: context);

            _proximaTela("Conta Encerrada com sucesso!");
          },
          onError: (error) => Mensagens().mensagem("Falha ao deletar", 
            true, context),
        );
      },
      onError: (error) => Mensagens().mensagem("Falha ao deletar", 
        true, context),
    );
  }

  _alteraPerfil(){
    Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => EditarPerfil(nome: _nomeUsuario)),);
  }

  Widget opcoes(String texto, Function() requerida){
    return TextButton(
      onPressed: requerida, 
      child: Text(texto, style: const TextStyle(color: Color(0xFF6D3F8C), fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
    
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
    
          children: [
    
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [              
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                const Text("Configurações", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
    
            Expanded(
    
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
    
                children: [
                  opcoes("Editar perfil", _alteraPerfil),
                  opcoes("Reiniciar dados", _restaurar),
                  opcoes("Deletar sua conta", _encerraConta),
                  opcoes("LOGOUT", _sair),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const TabBarInferior(telaAtual: 2),
    );
  }
}