import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/card_dados.dart';

class Dados extends StatefulWidget {
  
  const Dados({Key? key}) : super(key: key);

  @override
  State<Dados> createState() => _DadosState();
}

class _DadosState extends State<Dados> {

  late double _vendido = 0.0;
  late double _lucro = 0.0;
  late double _aReceber = 0.0;

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

  @override
  initState() {
    super.initState();
    _recebeDados();
  }

  _recebeDados() async {
    late double venda;
    late double arrecadado;
    late double recebe;

    await db.collection("Usuários").doc(usuarioID.toString()).get().then((doc) => {
      if(doc.exists){
        venda = doc.data()!["Vendido"],
        arrecadado = doc.data()!["Lucro"],
        recebe = doc.data()!["A Receber"]
      }
    },);

    setState(() {
      _lucro = arrecadado;
      _vendido = venda;
      _aReceber = recebe;
    });
  } 


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20),

      child: Column(

        children: [
          Expanded(
            flex: 1,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
          
              children: const [
                Text("Detalhes", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Expanded(
            flex: 9,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                CardDados(nome: "Vendido", valor: _vendido),
                CardDados(nome: "Lucro", valor: _lucro),
                CardDados(nome: "A Receber", valor: _aReceber),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
