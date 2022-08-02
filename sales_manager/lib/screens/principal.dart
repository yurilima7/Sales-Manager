import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_manager/components/botao_acesso.dart';
import 'package:sales_manager/components/card_inferior.dart';
import 'package:sales_manager/components/lista_recentes.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late String _nomeUsuario = "";
  late final List _ultimasVendas = [];

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

   @override
  initState() {
    super.initState();
    _recebeUsuario();
    _recebeVendas();
  }

  _recebeUsuario() async {
    late String nome;

    await db.collection("Usuários").doc(usuarioID.toString()).get().then((doc) => {
      if(doc.exists){
        nome = doc.data()!["Usuário"],
      }
    },);

    setState(() {
      _nomeUsuario = nome;
    });
  } 

   _recebeVendas() async{
    List vendas = [];

    await db.collection("Usuários").doc(usuarioID.toString())
    .collection("Últimas Vendas").get().then((querySnapshot) => {
        for (var doc in querySnapshot.docs){
          vendas.add(doc.data()),
        },
      });

    setState(() {
      _ultimasVendas.add(vendas);
       
    });
   }

  final _vendas = [
    {'Nome': "Fulano", 'Produto': "Cinto", 'valor': 20},
    {'Nome': "Siclano", 'Produto': "Cinto", 'valor': 25.5},
    {'Nome': "Beltrano", 'Produto': "Camisa", 'valor': 50},
    {'Nome': "Marciano", 'Produto': "Camisa", 'valor': 60},
  ];

  Future<String> getNome() async =>
    await Future.delayed(const Duration(seconds: 2), () {
      return _nomeUsuario;
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: FutureBuilder(
        
        future: getNome(),
        builder: (context, snapshot){

          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(), // remove o sombreamento da scroll
          
                slivers: [
          
                  SliverFillRemaining(
                    hasScrollBody: false,
          
                    child: Column(
                  
                      children: [
                        
                        Expanded( // nome de usuário e perfil
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            
                            children: [
                              Text(snapshot.data.toString(), style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                        
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
                                  onPressed: () => {Navigator.pushNamed(context, '/editarPerfil')}, 
                              
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
                                  BotaoAcesso(caminho: 'assets/icons/add pagamento.svg', titulo: "Adicionar Pagamentos", proximo: '/addPagamento'),
                                  BotaoAcesso(caminho: 'assets/icons/clientes.svg', titulo: "Consultar Clientes", proximo: '/clientes'),
                                  
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text("Últimas vendas", style: TextStyle(color: Color(0xFF6D3F8C), fontWeight: FontWeight.bold, fontSize: 16)),
                                  
                                ],
                              ),
                              // Listagem das vendas mais recentes do usuário
                              Column(
                              
                                children: [
                                  ListaRecentes(cliente: _vendas[0].values.elementAt(0).toString(), produto: _vendas[0].values.elementAt(1).toString(), valor: double.parse(_vendas[0].values.elementAt(2).toString())),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                  ListaRecentes(cliente: _vendas[1].values.elementAt(0).toString(), produto: _vendas[1].values.elementAt(1).toString(), valor: double.parse(_vendas[1].values.elementAt(2).toString())),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                  ListaRecentes(cliente: _vendas[2].values.elementAt(0).toString(), produto: _vendas[2].values.elementAt(1).toString(), valor: double.parse(_vendas[2].values.elementAt(2).toString())),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                  ListaRecentes(cliente: _vendas[3].values.elementAt(0).toString(), produto: _vendas[3].values.elementAt(1).toString(), valor: double.parse(_vendas[3].values.elementAt(2).toString())),
                                ],
                              ),
                            ],
                          ), 
                        ),
                        // Card de navegação no aplicativo
                        const CardInferior(ativo: true)
                      
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}
