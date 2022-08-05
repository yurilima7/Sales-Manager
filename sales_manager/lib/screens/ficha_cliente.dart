import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao_texto.dart';
import 'package:sales_manager/components/modelo_infomacional.dart';

class FichaCliente extends StatefulWidget {
  final String idCliente;
  final String nome;
  final double saldoDevedor;
  
  const FichaCliente({Key? key, required this.idCliente, required this.nome, required this.saldoDevedor}) : super(key: key);

  @override
  State<FichaCliente> createState() => _FichaClienteState();
}

class _FichaClienteState extends State<FichaCliente> {

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    Text(widget.nome, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),

                    IconButton(
                      onPressed: () => {Navigator.pushNamed(context, '/editarCliente')}, 
                        
                      icon: const Icon(Icons.edit, color: Color(0xFF6D3F8C)),
                    ),
                  ],
                ),

                const BotaoTexto(mensagem: "Pagamentos", proxima: "/pagos", tamanhoFonte: 16, desempilha: false),
              ],
            ),

            Expanded(
              flex: 2,

              child: StreamBuilder<QuerySnapshot <Map<String, dynamic>>>(
                
                stream: db.collection("Usuários").doc(usuarioID.toString())
                            .collection("Clientes").doc(widget.idCliente).collection("Produtos").snapshots(), 

                builder: (context, snapshot) {
                  
                  if (snapshot.hasData) {
                    return ListView(
                      physics: const BouncingScrollPhysics(), // remove o sombreamento da scroll

                      children: snapshot.data!.docs.map((doc){
                        return ModeloInfo(nome: doc.data()["Nome"], data: doc.data()["Data"], valor: doc.data()["Preço"] as double);
                      }).toList(),
                    );
                  }
                  else{
                    return const Center(
                      child: Text("Não existem produtos comprados!"),
                    );
                  }
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
              children: [
                const Text("Saldo Devedor", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                Text("R\$ ${widget.saldoDevedor}", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
