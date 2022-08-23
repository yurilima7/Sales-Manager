import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/widgets/card_informacoes.dart';
import 'package:sales_manager/screens/editar_cliente.dart';

class FichaCliente extends StatefulWidget {
  final String idCliente;
  final String nome, bairro, rua, telefone;
  final double saldoDevedor;
  
  const FichaCliente({Key? key, required this.idCliente, required this.nome, required this.saldoDevedor, 
    required this.bairro, required this.rua, required this.telefone}) 
    : super(key: key);

  @override
  State<FichaCliente> createState() => _FichaClienteState();
}

class _FichaClienteState extends State<FichaCliente> {

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário
  late double _aReceber = 0.0, _vendido = 0.0;
  late double _valoresDeletados = 0.0;

  @override
  initState(){ 
    super.initState();

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

  @override
  Widget build(BuildContext context) {

    void _editarCliente(){
      Navigator.push(
        context, 
        MaterialPageRoute<void>(builder: (BuildContext context) => 
          EditarCliente(idCliente: widget.idCliente, nome: widget.nome, bairro: widget.bairro,
          rua: widget.rua, telefone: widget.telefone, divida: widget.saldoDevedor)),
      );
    }

    return Scaffold(

      body: Padding(
        
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                const Text("Ficha do cliente", style: TextStyle(color: Colors.black, fontSize: 16))
              ]
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.08),

            Row(
              
              children: [
                Text(widget.nome, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),

                IconButton(
                  onPressed: () => _editarCliente(), 
                    
                  icon: const Icon(Icons.edit, color: Color(0xFF6D3F8C)),
                ),
              ],
            ),

            Expanded(
              flex: 2,

              child: StreamBuilder<QuerySnapshot <Map<String, dynamic>>>(
                // Buscando compras do cliente no banco
                stream: db.collection("Usuários").doc(usuarioID.toString())
                            .collection("Clientes").doc(widget.idCliente).collection("Produtos").snapshots(), 

                builder: (context, snapshot) {
                  
                  switch (snapshot.connectionState) {
                    
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.active:
                    case ConnectionState.done:
                      // caso não existam dados no baco
                      if(snapshot.data!.docs.isEmpty){
                        return const Center(
                          child: Text("Sem compras no momento!", style: TextStyle(color: Color(0xFF6D3F8C), fontSize: 16)),
                        );
                      }
                      // Se existirem dados, os apresentam
                      return ListView(
                        physics: const BouncingScrollPhysics(), // remove o sombreamento da scroll

                        children: snapshot.data!.docs.map((doc){
                        return ModeloInfo(nome: doc.data()["Nome"], data: doc.data()["Data"].toDate(), valor: doc.data()["Preço"] as double
                            , idCliente: widget.idCliente, idProduto: doc.id, idUsuario: usuarioID
                            , saldoDevedor: widget.saldoDevedor, quantidade: doc.data()["Quantidade"]
                            , aReceber: _aReceber, deletados: _valoresDeletados, vendido: _vendido
                            , idVenda: doc.data()["Id"], totalAtual: doc.data()["Total"]);
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
