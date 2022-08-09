import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/card_cliente_simples.dart';
import 'package:sales_manager/objects/produto.dart';

class SelecionaProduto extends StatefulWidget {

  final String nomeCliente, idCliente;
  final double divida;

  const SelecionaProduto({Key? key, required this.nomeCliente, 
        required this.idCliente, required this.divida}) : super(key: key);

  @override
  State<SelecionaProduto> createState() => _SelecionaProdutoState();
}

class _SelecionaProdutoState extends State<SelecionaProduto> {

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário
  List<Produto> _produtos = [];

  @override
  initState(){ 
    super.initState();

    _lerProdutos().then((retorno) =>
      setState(() => _produtos = retorno),
    );
  }

  // future responsável por listar os dados iniciais
  Future<List<Produto>> _lerProdutos() async { 
    late final List<Produto> busca;

    await db.collection("Usuários").doc(usuarioID.toString())
      .collection("Clientes").doc(widget.idCliente).collection("Produtos")
      .orderBy("Nome").get()
      .then((QuerySnapshot snapshot) {
        busca = snapshot.docs.map(
          (doc) => Produto(
            doc["Nome"],
            doc["Data"],
            doc["Quantidade"],
            doc["Preço"],
            doc.id,
          )).toList();
      });

    return busca;
  }

  Widget _listagem(){

    if(_produtos.isEmpty){
      return const Expanded(
        child: Center(
            child: Text("O cliente não possui compras!", style: TextStyle(color: Color(0xFF6D3F8C), fontSize: 16))),
      );
    }
    else{
      List<Produto> filtra = _produtos;
      // retorna a lista de cards de usuários 
      return Expanded(
        child: Column(
          children: List.generate(filtra.length, (index) => 
            ClienteSimples(produtos: filtra[index], idCliente: widget.idCliente, divida: widget.divida),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Text(widget.nomeCliente, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),

            _listagem()
          ],
        ),
      ),
    );
  }
}