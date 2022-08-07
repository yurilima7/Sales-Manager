import 'package:flutter/material.dart';
import 'package:sales_manager/components/modelo_infomacional.dart';

class Pagos extends StatelessWidget {
  const Pagos({Key? key}) : super(key: key);

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
                const Text("Produtos pagos", style: TextStyle(color: Colors.black, fontSize: 16))
              ]
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.08),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                
                Row(
                  children:const [
                    Text("Marciano", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),

            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  Column(
              
                    children: const [
                      // ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: 50, icones: false),
                      // ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: 50, icones: false),
                      // ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: 50, icones: false),
                      // ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: 50, icones: false),
                      // ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: 50, icones: false),
                      
                    ],
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
              children: const [
                Text("Total Pago", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                Text("R\$ 250", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}