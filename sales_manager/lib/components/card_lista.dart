import 'package:flutter/material.dart';
import 'package:sales_manager/screens/seleciona_compra.dart';

class CardLista extends StatelessWidget {
  final String nome, id;
  final double valor;

  const CardLista({Key? key, required this.nome, required this.valor, 
                  required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: const Color(0xFF6D3F8C),
        elevation: 3,
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        
        child: ElevatedButton(

          onPressed: () { 
            Navigator.push(
            context, 
            MaterialPageRoute<void>(builder: (BuildContext context) => 
              SelecionaProduto(nomeCliente: nome, idCliente: id, divida: valor)),
          );
          },

          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            elevation: 3,
          ),

          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            
            child: Column(
              
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children:  [
                    Text(nome, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            
                    Text("R\$ $valor", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
