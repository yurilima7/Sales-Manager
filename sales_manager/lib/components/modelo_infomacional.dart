import 'package:flutter/material.dart';

class ModeloInfo extends StatelessWidget {
  final String nome;
  final String data;
  final String valor;
  final bool icones;
  
  const ModeloInfo({Key? key, required this.nome, required this.data, required this.valor, this.icones = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(nome, style: const TextStyle(color: Colors.black, fontSize: 16)),
        Text(data, style: const TextStyle(color: Colors.black, fontSize: 16)),
        Text(valor, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),

        icones ? IconButton(
          onPressed: () => {}, 
            
          icon: const Icon(Icons.delete, color: Color(0xFF6D3F8C)),
        ) : const SizedBox(),

        icones ? IconButton(
          onPressed: () => {Navigator.pushNamed(context, '/editarProduto')}, 
            
          icon: const Icon(Icons.edit, color: Color(0xFF6D3F8C)),
        ) : const SizedBox()
      ],
    );
  }
}
