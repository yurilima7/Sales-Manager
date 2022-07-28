import 'package:flutter/material.dart';
import 'package:sales_manager/components/card_cliente.dart';
import 'package:sales_manager/components/pesquisa.dart';

class Clientes extends StatelessWidget {
  const Clientes({Key? key}) : super(key: key);

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
              
              child: ListView(
                
                children: const [
                  CardCliente(proximo: '/fichaCliente'),
                  CardCliente(proximo: '/fichaCliente'),
                  CardCliente(proximo: '/fichaCliente'),
                  CardCliente(proximo: '/fichaCliente'),
                  CardCliente(proximo: '/fichaCliente'),
                  CardCliente(proximo: '/fichaCliente'),
                ],
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
