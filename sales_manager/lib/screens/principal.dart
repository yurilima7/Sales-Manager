import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_manager/util/formato_numero.dart';
import 'package:sales_manager/widgets/tap_bar_telas.dart';
import 'package:sales_manager/widgets/botao_acesso.dart';
import 'package:sales_manager/widgets/lista_recentes.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late String _nomeUsuario = "";
  late double _vendido = 0.0;

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

  @override
  initState() {   
    _recebeUsuario();
    super.initState();
  }

  _recebeUsuario() async {
    late String nome;
    late double valor;
    final usuario = FirebaseAuth.instance.currentUser?.displayName.toString();

    await db.collection("Usuários").doc(usuarioID.toString()).get().then((doc) => {
      if(doc.exists){
        nome = doc.data()!["Usuário"],
        valor = doc.data()!["Vendido"],
      }
      else{
        db.collection("Usuários").doc(usuarioID).set({ // adicionando informações do usuário no banco de dados
          "Usuário": usuario,
          "Lucro": 0.0,
          "A Receber": 0.0,
          "Vendido": 0.0,
          "Quantidade de Vendas": 0,
          "Valores Deletados": 0.0
        }),
        valor = 0.0,
        nome = usuario.toString(),
      }
    },);

    setState(() {
      _nomeUsuario = nome;
      _vendido = valor;
    });
  } 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 20),
        
        child: SingleChildScrollView(
    
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
    
            children: [
              // apresenta o nome do usuário
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.042,
    
                child: Text(_nomeUsuario, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              // Card de informações de vendas
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
    
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
    
                  children: [
                    
                    Card( 
                      color: const Color(0xFF6D3F8C),
                      elevation: 3,
                      
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                
                      child: Container(
                        padding: const EdgeInsets.all(20),

                        child: ListTile(
                      
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              
                              children:  [
                                const Text("Vendido", style: TextStyle(color: Colors.white, fontSize: 16)),
                                const SizedBox(height: 2),
                                Text(FormatoNumero().formatoBR(_vendido), style: const TextStyle(color: Colors.white, fontSize: 16)),
                              ],
                            ),
                                      
                          trailing: SvgPicture.asset(
                              'assets/icons/carteira.svg',
                              height: MediaQuery.of(context).size.height * 0.04,
                              allowDrawingOutsideViewBox: true,
                            ),
                        ),
                      ),
                    ),
              
                    // Botões de ações do aplicativo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                
                        BotaoAcesso(caminho: 'assets/icons/vendas.svg', titulo: "Adicionar Vendas", proximo: 0),
                        BotaoAcesso(caminho: 'assets/icons/add pagamento.svg', titulo: "Adicionar Pagamentos", proximo: 1),
                        BotaoAcesso(caminho: 'assets/icons/clientes.svg', titulo: "Consultar Clientes", proximo: 2),
                        
                      ],
                    ),
                  ],
                ),
              ),
              // Lista as últimas 10 vendas
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.42,
    
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // colocada no fim da tela
    
                  children: [                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
              
              
                      children: const [
                        Text("Últimas vendas", style: TextStyle(color: Color(0xFF6D3F8C), fontWeight: FontWeight.bold, fontSize: 16)),   
                      ],
                    ),
                    // coluna que apresenta as últimas vendas
                    Column( 
                      
                      children: [
              
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.27,
                          child: StreamBuilder<QuerySnapshot <Map<String,dynamic>>>(
                            // buscando as últmas 10 vendas no banco
                            stream: db.collection("Usuários").doc(usuarioID.toString())
                              .collection("Últimas Vendas").orderBy("Id", descending: true).limit(10).snapshots(), 
              
                            builder: (context, snapshot){
                              
                              switch(snapshot.connectionState){
                                
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
    
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  // Caso não existam dados
                                  if (snapshot.data!.docs.isEmpty){
                                    return const Center(
                                      child: Text("Sem vendas recentes!", style: TextStyle(color: Color(0xFF6D3F8C), fontSize: 16)),
                                    );
                                  }
                                  // Se existirem dados, os apresentam
                                  return ListView(
                                    physics: const BouncingScrollPhysics(), // remove o sombreamento da scroll
                                    children: snapshot.data!.docs.map((doc){
    
                                      return SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.065,
                                        child: ListaRecentes(cliente: doc.data()["Nome"], produto: doc.data()["Produto"], valor: doc.data()["Preço"]),
                                      );
    
                                    }).toList(),
                                  );
                                  
                              }
                            }
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),     
        ),
      ),

      bottomNavigationBar: const TabBarInferior(telaAtual: 0),
    );
  }
}
