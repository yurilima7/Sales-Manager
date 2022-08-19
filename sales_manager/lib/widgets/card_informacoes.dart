import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_manager/screens/editar_compra.dart';
import 'package:sales_manager/util/formato_numero.dart';
import 'package:sales_manager/util/mensagens.dart';

class ModeloInfo extends StatelessWidget {
  final String nome, idCliente, idProduto;
  final String idUsuario;
  final DateTime data;
  final double valor, saldoDevedor, aReceber, deletados, vendido;
  final int quantidade, idVenda;
  
  const ModeloInfo({Key? key, required this.nome, required this.data, required this.valor
  , required this.idCliente, required this.idProduto
  , required this.idUsuario, required this.saldoDevedor, required this.quantidade
  , required this.aReceber, required this.deletados, required this.vendido
  , required this.idVenda}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {

    final db = FirebaseFirestore.instance;
    final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

    void _editarCompra(){
      Navigator.push(
        context, 
        MaterialPageRoute<void>(builder: (BuildContext context) => 
          EditarCompra(nome: nome, data: data, idProduto: idProduto, idCliente: idCliente, 
              idUsuario: idUsuario, preco: valor, saldoDevedor: saldoDevedor, 
              quantidadeAnterior: quantidade, idVenda: idVenda)), 
      );
    }

    void _deletaProduto() async{
      bool deletou = false;
      // deletando produto comprado
      await db.collection("Usuários").doc(usuarioID).collection("Clientes").doc(idCliente)
        .collection("Produtos").doc(idProduto).delete();

      // atualizando dados do cliente
      await db.collection("Usuários").doc(usuarioID).collection("Clientes").doc(idCliente)
        .update({
          "Saldo Devedor": saldoDevedor - (valor * quantidade),
        });

      // atualizando dados do usuário
      await db.collection("Usuários").doc(usuarioID).update({
        "A Receber": aReceber - (valor * quantidade),
        "Valores Deletados": deletados + (valor * quantidade),
        "Vendido": vendido - (valor * quantidade),
      });

      // deletando das vendas feitas
      await db.collection("Usuários").doc(usuarioID).collection("Últimas Vendas").orderBy("Id", descending: true).get()
      .then((QuerySnapshot snapshot) => {
        for(var doc in snapshot.docs){
  
          if(doc["Produto"] == nome && doc["Cliente Id"] == idCliente 
            && doc["Preço"] == valor && deletou == false){
            doc.reference.delete(),
            deletou = true,
          }
        }
      });
    }

    return Card(
      elevation: 3,
      color: const Color(0xFF6D3F8C),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

      child: Container(
        padding: const EdgeInsets.all(10), // afastamento

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ListTile(

              title: Row(                 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(nome, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                  IconButton(
                    onPressed: () => {
                      _deletaProduto(),
                       Mensagens().mensagem("Compra deletada com sucesso!", false, context),
                    }, 
                    alignment: Alignment.topCenter,
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Divider(color: Colors.white),

                  Text("Data: ${DateFormat('dd/MM/y').format(data)}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                  Text("Quantidade: $quantidade", style: const TextStyle(color: Colors.white, fontSize: 16)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text("Unidade: ${FormatoNumero().formatoBR(valor)}", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                      IconButton(
                        onPressed: () => _editarCompra(), 
                        alignment: Alignment.topCenter,
                        icon: const Icon(Icons.edit, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
