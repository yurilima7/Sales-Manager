import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/card_cliente.dart';
import 'package:sales_manager/components/pesquisa.dart';

class Clientes extends StatefulWidget {
  const Clientes({Key? key}) : super(key: key);

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

  @override
  Widget build(BuildContext context) {
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
                    const Text("Consultar clientes", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const Pesquisa(label: "Buscar Cliente"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              ],
            ),

            Expanded(
              
              child: StreamBuilder<QuerySnapshot <Map<String, dynamic>>>(
                
                stream: db.collection("Usuários").doc(usuarioID.toString())
                            .collection("Clientes").snapshots(), 

                builder: (context, snapshot) {
                  
                  if (snapshot.hasData) {
                    return ListView(
                      physics: const BouncingScrollPhysics(), // remove o sombreamento da scroll

                      children: snapshot.data!.docs.map((doc){
                        return CardCliente(id: doc.id, bairro: doc.data()["Bairro"], divida: doc.data()["Saldo Devedor"], nome: doc.data()["Nome"], rua: doc.data()["Endereço"], telefone: doc.data()["Telefone"]);
                      }).toList(),
                    );
                  }
                  else{
                    return const Center(
                      child: Text("Não existem clientes cadastrados!"),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
