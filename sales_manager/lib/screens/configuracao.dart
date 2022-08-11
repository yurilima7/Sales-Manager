import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/screens/editar_perfil.dart';
import 'package:sales_manager/screens/estado_usuario.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({Key? key}) : super(key: key);

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {

  late String _nomeUsuario = "";

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário
  final usuario = FirebaseAuth.instance.currentUser;

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

    _mensagem(mensagem);

    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const EstadoUsuario()),
        (route) => false,
      );
    }); 
  }

  _mensagem(String texto){
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(texto),
      backgroundColor:  Colors.greenAccent,
    )
  );
  }

  _sair() async {
    await FirebaseAuth.instance.signOut();

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

  _restaurar() async{

    _apagaClientes();

    // reinicia os dados do usuário
    await db.collection("Usuários").doc(usuarioID).update({
      "Lucro": 0.0,
      "A Receber": 0.0,
      "Vendido": 0.0,
      "Quantidade de Vendas": 0,
      "Valores Deletados": 0.0
    });

    _mensagem("Dados restaurados com sucesso!");
  }

  _encerraConta() async{

    _apagaClientes();

    // deleta todos os dados do usuário no banco
    await db.collection("Usuários").doc(usuarioID).delete();

    usuario?.delete();
    
    await FirebaseAuth.instance.signOut();

    _proximaTela("Conta Encerrada com sucesso!");
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

    return Padding(
      padding: const EdgeInsets.all(20.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Expanded(
            flex: 1,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
          
                Ink(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.007),
                  
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
            
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5
                      )
                    ]
                  ),
            
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF734D8C),
                  ),
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(_nomeUsuario, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Expanded(
            flex: 5,

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
    );
  }
}