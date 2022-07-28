import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao_texto.dart';
import 'package:sales_manager/components/modelo_infomacional.dart';

class FichaCliente extends StatelessWidget {
  const FichaCliente({Key? key}) : super(key: key);

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
                const Text("Ficha do cliente", style: TextStyle(color: Colors.black, fontSize: 16))
              ]
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.08),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    const Text("Marciano", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),

                    IconButton(
                      onPressed: () => {Navigator.pushNamed(context, '/editarCliente')}, 
                        
                      icon: const Icon(Icons.edit, color: Color(0xFF6D3F8C)),
                    ),
                  ],
                ),

                const BotaoTexto(mensagem: "Pagamentos", proxima: "/pagos", tamanhoFonte: 16, desempilha: false),
              ],
            ),

            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  Column(
              
                    children: const [
                      ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: "R\$ 50"),
                      ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: "R\$ 50"),
                      ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: "R\$ 50"),
                      ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: "R\$ 50"),
                      ModeloInfo(nome: "Camisa", data: "18/06/2022", valor: "R\$ 50"),
                      
                    ],
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
              children: const [
                Text("Saldo Devedor", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                Text("R\$ 250", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
