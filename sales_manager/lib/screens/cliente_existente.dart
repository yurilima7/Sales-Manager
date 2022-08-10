import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/card_lista.dart';
import 'package:sales_manager/components/pesquisa.dart';
import 'package:sales_manager/objects/cliente.dart';

class ClienteExistente extends StatefulWidget {
  const ClienteExistente({Key? key}) : super(key: key);

  @override
  State<ClienteExistente> createState() => _ClienteExistenteState();
}

class _ClienteExistenteState extends State<ClienteExistente> {

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário
  List<Cliente> _clientes = [];
  String buscando = '';
  final _pesquisa = TextEditingController();

   @override
  initState(){ 
    super.initState();

    _lerClientes().then((retorno) =>
      setState(() => _clientes = retorno),
    );
  }

  // future responsável por listar os dados iniciais
  Future<List<Cliente>> _lerClientes() async { 
    late final List<Cliente> busca;

    await db.collection("Usuários").doc(usuarioID.toString())
      .collection("Clientes").orderBy("Nome").get()
      .then((QuerySnapshot snapshot) {
        busca = snapshot.docs.map(
          (doc) => Cliente(
            doc["Nome"],
            doc["Endereço"],
            doc["Bairro"],
            doc["Telefone"],
            doc["Saldo Devedor"],
            doc.id
          )).toList();
      });

    return busca;
  }

  // função que retorna um widget 
  Widget _listagem(){ 
    // retorna a mensagem de campo vázio
    if (_clientes.isEmpty) { 
      return const Expanded(
        child: Center(
            child: Text("Sem clientes cadastrados!", style: TextStyle(color: Color(0xFF6D3F8C), fontSize: 16))),
      );
    }
    else{
      List<Cliente> filtra = _clientes
          .where((p) => p.nome.toLowerCase().contains(buscando.toLowerCase()))
          .toList();
      // retorna a lista de cards de usuários 
      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(filtra.length, (index) => 
              CardLista(nome: filtra[index].nome, valor: filtra[index].divida
                        , id: filtra[index].id, selecionaProduto: false)
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    void onChanged(String text){
      setState(() {
        buscando = _pesquisa.text;
      });
    }

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20), 

        child: Column(
        
          children: [
          
            Column(
            
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
            
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    const Text("Clientes", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Pesquisa(label: "Buscar Cliente", controller: _pesquisa, onChanged: onChanged),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              ],
            ),

            _listagem()
          ],
        ),
      ),
    );
  }
}