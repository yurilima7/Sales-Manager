import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_manager/screens/editar_compra.dart';

class ModeloInfo extends StatelessWidget {
  final String nome, idCliente, idProduto;
  final String idUsuario;
  final DateTime data;
  final double valor, saldoDevedor, aReceber, deletados, vendido;
  final bool icones;
  final int quantidade;
  
  const ModeloInfo({Key? key, required this.nome, required this.data, required this.valor
  , this.icones = true, required this.idCliente, required this.idProduto
  , required this.idUsuario, required this.saldoDevedor, required this.quantidade
  , required this.aReceber, required this.deletados, required this.vendido}) 
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
              idUsuario: idUsuario, preco: valor, saldoDevedor: saldoDevedor, quantidadeAnterior: quantidade)
      ));
    }

    void _deletaProduto() async{
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
      await db.collection("Usuários").doc(usuarioID.toString()).collection("Últimas Vendas").doc(idCliente).delete();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(nome, style: const TextStyle(color: Colors.black, fontSize: 16)),
        Text(DateFormat('dd/MM/y').format(data), style: const TextStyle(color: Colors.black, fontSize: 16)),
        Text(valor.toString(), style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            icones ? IconButton(
              onPressed: () => _deletaProduto(), 
                
              icon: const Icon(Icons.delete, color: Color(0xFF6D3F8C)),
            ) : const SizedBox(),

            icones ? IconButton(
              onPressed: () => _editarCompra(), 
                
              icon: const Icon(Icons.edit, color: Color(0xFF6D3F8C)),
            ) : const SizedBox()
          ],
        )
      ],
    );
  }
}
