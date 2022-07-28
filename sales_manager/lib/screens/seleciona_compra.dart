import 'package:flutter/material.dart';
import 'package:sales_manager/components/card_cliente_simples.dart';

class SelecionaProduto extends StatelessWidget {
  const SelecionaProduto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                const Text("Marciano", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),

            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  Column(
              
                    children: const [
                      ClienteSimples(nome: "Marciano", valor: "R\$ 250")
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