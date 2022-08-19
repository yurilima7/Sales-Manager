import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/util/mensagens.dart';
import 'package:sales_manager/widgets/card_cliente.dart';
import 'package:sales_manager/widgets/pesquisa.dart';
import 'package:sales_manager/objects/cliente.dart';

class Clientes extends StatefulWidget {
  const Clientes({Key? key}) : super(key: key);

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário
    List<Cliente> _clientes = [];
    String buscando = '';
    final _pesquisa = TextEditingController();
    late double _aReceber = 0.0, _vendido = 0.0;
    late double _valoresDeletados = 0.0;

  @override
  initState(){ 
    super.initState();

    _lerClientes().then((retorno) =>
      setState(() => _clientes = retorno),
    );

    _dadosUsuario();
  }
  // recebendo valores para atualização nos dados do usuário
  void _dadosUsuario() async {
    double temp1 = 0.0;
    double temp2 = 0.0, temp3 = 0.0;

    await db.collection("Usuários").doc(usuarioID.toString()).get()
      .then((doc) => {
        if(doc.exists){
          temp1 = doc.data()!["A Receber"],
          temp2 = doc.data()!["Valores Deletados"],
          temp3 = doc.data()!["Vendido"],
        }
      });

    setState(() {
      _aReceber = temp1;
      _valoresDeletados = temp2;
      _vendido = temp3;
    });
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
          // desativa o teclado rolar a lista
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

          child: Column(
            children: List.generate(filtra.length, (index) => 
              CardCliente(nome: filtra[index].nome, telefone: filtra[index].telefone, 
                    bairro: filtra[index].bairro, rua: filtra[index].endereco, 
                    divida: filtra[index].divida, id: filtra[index].id, funcao: _deleta)
            ),
          ),
        ),
      );
    }
  }

  // função que deleta o cliente do banco
  void _deleta(String idCliente, double divida, String nome) async { 
    // deletando o cliente
    await db.collection("Usuários").doc(usuarioID).collection("Clientes").doc(idCliente).delete().then(
      (doc) => {
        // coleções do cliente
        db.collection("Usuários").doc(usuarioID).collection("Clientes").doc(idCliente)
          .collection("Produtos").get().then((QuerySnapshot querySnapshot) => {
            for (var doc in querySnapshot.docs){
              doc.reference.delete()
            },
          }
        ),
        // venda reccente feita para o cliente
        db.collection("Usuários").doc(usuarioID).collection("Últimas Vendas").get()
        .then((QuerySnapshot snapshot) => {
          for(var doc in snapshot.docs){

            if(doc["Nome"] == nome && doc["Cliente Id"] == idCliente){
              doc.reference.delete(),
            }
          }
        }),
        // atualizando dados do usuário
        db.collection("Usuários").doc(usuarioID.toString()).update({
          "A Receber": _aReceber - divida,
          "Valores Deletados": _valoresDeletados + divida,
          "Vendido": _vendido - divida,
        }),

        setState(() { // atualiza a tela pós deletar os dados do cliente
          for(var i = 0; i < _clientes.length; i++){
            if(_clientes[i].id == idCliente){_clientes.removeAt(i);}
          }
        }),

        Mensagens().mensagem("Deletado com sucesso!", false, context),
      },
      onError: (e) => Mensagens().mensagem("Problemas ao deletar, tente novamente!", true, context),
    );
  }

  @override
  Widget build(BuildContext context) {
    // responśvel por ver cada letra digitada
    void onChanged(String text){
      setState(() {
        buscando = _pesquisa.text;
      });
    }

    return GestureDetector(
      // desativa o teclado ao tocar na tela
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(), 

      child: Scaffold(
    
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5), 
        
          child: Column(
          
            children: [
              Column(
              
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
              
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                      const Text("Consultar clientes", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
