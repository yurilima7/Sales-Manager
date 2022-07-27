import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_manager/components/botao_acesso.dart';
import 'package:sales_manager/components/card_inferior.dart';
import 'package:sales_manager/components/lista_recentes.dart';

class Principal extends StatelessWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20), 

        child: Column(
          
          children: [

            Expanded( // nome de usuário e perfil
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  const Text("Bob", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),

                  Ink(
                    
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5
                        )
                      ]
                    ),

                    width: MediaQuery.of(context).size.width * 0.11,

                    child: IconButton(
                      onPressed: () => {}, 
                  
                      icon: SvgPicture.asset(
                        'assets/icons/pessoa.svg',
                        height: MediaQuery.of(context).size.height * 0.025,
                        width: MediaQuery.of(context).size.width * 0.025,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 4,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  // Card de informações de vendas
                  Card( 
                    color: const Color(0xFF6D3F8C),
                    elevation: 3,
                    
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            
                    child: Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
            
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            
                            children: const [
                              Text("Vendido", style: TextStyle(color: Colors.white, fontSize: 16)),
                              SizedBox(height: 2),
                              Text("R\$ 200", style: TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
            
                          SvgPicture.asset(
                            'assets/icons/carteira.svg',
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.04,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ],
                      ),
                    ),
                  ),
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  // Botões de ações do aplicativo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
            
                      BotaoAcesso(caminho: 'assets/icons/vendas.svg', titulo: "Adicionar Vendas", proximo: '/opcaoDeVenda'),
                      BotaoAcesso(caminho: 'assets/icons/add pagamento.svg', titulo: "Adicionar Pagamentos", proximo: ''),
                      BotaoAcesso(caminho: 'assets/icons/clientes.svg', titulo: "Consultar Clientes", proximo: ''),
                      
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Row(
                    children: [
                      const Text("Últimas vendas", style: TextStyle(color: Color(0xFF6D3F8C), fontWeight: FontWeight.bold, fontSize: 16)),
                      Container()
                    ],
                  ),
                  // Listagem das vendas mais recentes do usuário
                  Column(
                   
                    children: [
                      const ListaRecentes(cliente: "Fulano", produto: "Cinto", valor: 20.0),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      const ListaRecentes(cliente: "Siclano", produto: "Cinto", valor: 25.5),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      const ListaRecentes(cliente: "Beltrano", produto: "Calça", valor: 60.0),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      const ListaRecentes(cliente: "Marciano", produto: "Camisa", valor: 50.0),
                    ],
                  ),
                ],
              ),
            ),
            // Card de navegação no aplicativo
            const Expanded(flex: 1, child: CardInferior(caminho: 'assets/icons/home.svg', caminho2: 'assets/icons/dados.svg', caminho3: 'assets/icons/configurações.svg'))
          
          ],
        ),
      ),
    );
  }
}
