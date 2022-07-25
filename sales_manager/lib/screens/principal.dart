import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao_acesso.dart';
import 'package:sales_manager/components/lista_recentes.dart';

class Principal extends StatelessWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0), 

        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Bob", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                Image.asset(
                  'assets/icons/pessoa.png',
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            Card(
              color: const Color(0xFF6D3F8C),
              elevation: 3,
              
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

              child: Padding(
                padding: const EdgeInsets.all(30.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: const [
                        Text("Vendido", style: TextStyle(color: Colors.white, fontSize: 16)),
                        SizedBox(height: 8),
                        Text("R\$ 200", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),

                    Image.asset(
                      'assets/icons/carteira.png',
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [

                BotaoAcesso(local: 'assets/icons/vendas.png', titulo: "Adicionar Vendas"),
                BotaoAcesso(local: 'assets/icons/add pagamento.png', titulo: "Adicionar Pagamentos"),
                BotaoAcesso(local: 'assets/icons/clientes.png', titulo: "Consultar Clientes"),
                
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.06),

            Row(
              children: [
                const Text("Últimas vendas", style: TextStyle(color: Color(0xFF6D3F8C), fontWeight: FontWeight.bold, fontSize: 16)),
                Container()
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            Column(
              children: [
                const ListaRecentes(cliente: "Fulano", produto: "Cinto", valor: 20.0),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const ListaRecentes(cliente: "Siclano", produto: "Cinto", valor: 25.5),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const ListaRecentes(cliente: "Beltrano", produto: "Calça", valor: 60.0),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const ListaRecentes(cliente: "Marciano", produto: "Camisa", valor: 50.0),
              ],
            )
          
          ],
        ),
      ),
    );
  }
}
