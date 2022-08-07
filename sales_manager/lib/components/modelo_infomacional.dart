import 'package:flutter/material.dart';
import 'package:sales_manager/screens/editar_compra.dart';

class ModeloInfo extends StatelessWidget {
  final String nome, idCliente, idProduto;
  final String data, idUsuario;
  final double valor, saldoDevedor;
  final bool icones;
  final int quantidade;
  
  const ModeloInfo({Key? key, required this.nome, required this.data, required this.valor
  , this.icones = true, required this.idCliente, required this.idProduto
  , required this.idUsuario, required this.saldoDevedor, required this.quantidade}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _editarCompra(){
      Navigator.push(
        context, 
        MaterialPageRoute<void>(builder: (BuildContext context) => 
          EditarCompra(nome: nome, data: data, idProduto: idProduto, idCliente: idCliente, 
              idUsuario: idUsuario, preco: valor, saldoDevedor: saldoDevedor, quantidadeAnterior: quantidade)
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(nome, style: const TextStyle(color: Colors.black, fontSize: 16)),
        Text(data, style: const TextStyle(color: Colors.black, fontSize: 16)),
        Text(valor.toString(), style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),

        icones ? IconButton(
          onPressed: () => {}, 
            
          icon: const Icon(Icons.delete, color: Color(0xFF6D3F8C)),
        ) : const SizedBox(),

        icones ? IconButton(
          onPressed: () => {_editarCompra()}, 
            
          icon: const Icon(Icons.edit, color: Color(0xFF6D3F8C)),
        ) : const SizedBox()
      ],
    );
  }
}
