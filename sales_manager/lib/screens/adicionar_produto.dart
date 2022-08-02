import 'package:flutter/material.dart';
import 'package:sales_manager/components/novo_produto.dart';
import 'package:sales_manager/models/produto.dart';

class AdicionarProduto extends StatefulWidget {
  final String nome;
  const AdicionarProduto({required this.nome ,Key? key}) : super(key: key);

  @override
  State<AdicionarProduto> createState() => _AdicionarProdutoState();
}

class _AdicionarProdutoState extends State<AdicionarProduto> {

  final List <Produto> _produtos = [];

  _addProduto(String nome, String data, double preco, int quantidade){

    final novoProduto = Produto(
      nome: nome,
      data: data,
      preco: preco,
      quantidade: quantidade,
    );

    setState(() {
      _produtos.add(novoProduto);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

        child: Padding(
          padding: const EdgeInsets.all(20),
      
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              
              children: [
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    const Text("Adicionar produto", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
          
                NovoProduto(guardaDados: _addProduto, clienteNome: widget.nome),
      
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}