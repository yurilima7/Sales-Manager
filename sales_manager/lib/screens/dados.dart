import 'package:flutter/material.dart';
import 'package:sales_manager/components/card_dados.dart';
import 'package:sales_manager/components/card_inferior.dart';

class Dados extends StatelessWidget {
  
  const Dados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [
            Expanded(
              flex: 1,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
            
                children: const [
                  Text("Detalhes", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            Expanded(
              flex: 9,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: const [
                  CardDados(nome: "Vendido",),
                  CardDados(nome: "Recebido"),
                  CardDados(nome: "A Receber"),
                ],
              ),
            ),

            const CardInferior(ativo2: true)
          ],
        ),
      ),
    );
  }
}
