import 'package:flutter/material.dart';
import 'package:sales_manager/components/card_lista.dart';
import 'package:sales_manager/components/pesquisa.dart';

class AdicionarPagamento extends StatelessWidget {
  const AdicionarPagamento({Key? key}) : super(key: key);

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
                    const Text("Clientes", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const Pesquisa(label: "Buscar Cliente"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              ],
            ),

            Expanded(
              
              child: ListView(
                
                children: const [
                  
                  CardLista(proximo: '/selecionaCompra'),
                  CardLista(proximo: '/selecionaCompra'),
                  CardLista(proximo: '/selecionaCompra'),
                  CardLista(proximo: '/selecionaCompra'),
                ],
                
              ),
            )
          ],
        ),
      ),
    );
  }
}