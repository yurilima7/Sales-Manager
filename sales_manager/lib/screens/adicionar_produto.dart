import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/screens/principal.dart';
import 'package:sales_manager/widgets/botao.dart';
import 'package:sales_manager/widgets/input_formulario.dart';
import 'package:sales_manager/widgets/insere_data.dart';
import 'package:sales_manager/util/mensagens.dart';

class AdicionarProduto extends StatefulWidget {
  final String nome;
  final bool clienteExistente;
  final double divida;

  const AdicionarProduto({required this.nome, this.clienteExistente = false
    , this.divida = 0.0, Key? key}) : super(key: key);

  @override
  State<AdicionarProduto> createState() => _AdicionarProdutoState();
}

class _AdicionarProdutoState extends State<AdicionarProduto> {

  final _nomeControler = TextEditingController();
  DateTime _data = DateTime.now();
  final _precoControler = TextEditingController();
  final _quantidadeControler = TextEditingController();
  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário
  late double _aReceber, _totalVendido;
  late String _idCliente;
  late int _qtdVenda;

  @override
  initState() {
    super.initState();
    _recebeDados();
    _recebeLucro();
  }

  _recebeDados() async {
    var nomes = [];
    var ids = [];
    late int pos;

    await db.collection("Usuários").doc(usuarioID.toString()).collection("Clientes").get()
      .then((querySnapshot) => {
        for (var doc in querySnapshot.docs){
          nomes.add(doc.data()["Nome"]),
          ids.add(doc.id),
        },
      },
    );

    for (var i = 0; i < nomes.length; i++){
      if(nomes[i] == widget.nome){
        pos = i;
      }
    }

    for (var j = 0; j < ids.length; j++){
      if(j == pos){
        setState(() {
          _idCliente = ids[j];
        });
      }
    }
  }

  _recebeLucro() async{
    late double val, vendido;
    late int quantidade;

    await db.collection("Usuários").doc(usuarioID.toString()).get().then((doc) => {
      if(doc.exists){
        val = (doc.data()!["A Receber"]) as double,
        quantidade = doc.data()!["Quantidade de Vendas"],
        vendido = (doc.data()!["Vendido"]) as double,
      }
    },);

    setState(() {
      _aReceber = val;
      _qtdVenda = quantidade;
      _totalVendido = vendido;
    });
    

  }

  void _proximaTela() async {

    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => const Principal()),
      (route) => false,
    );
  }

  void _atualizaDivida(double preco, int quantidade) async{
      if(widget.clienteExistente == true){
        // adicionando o campo de divida do cliente
        db.collection("Usuários").doc(usuarioID).collection("Clientes") 
          .doc(_idCliente).update({
            "Saldo Devedor": widget.divida + (preco * quantidade),
        });
      }
      else{
        // adicionando o campo de divida do cliente
        db.collection("Usuários").doc(usuarioID).collection("Clientes") 
          .doc(_idCliente).update({
            "Saldo Devedor": preco * quantidade,
        });
      }
  }

  _guardandoDados() async {
    final nome = _nomeControler.text;
    final data = _data;
    final preco = double.tryParse(_precoControler.text);
    final quantidade = int.tryParse(_quantidadeControler.text);

    if(_nomeControler.text == '' && _precoControler.text == '' && _quantidadeControler.text == ''){
      Mensagens().mensagem("Todos os campos vazios!", true, context);

      return;
    }

    if(_nomeControler.text == ''){
      Mensagens().mensagem("Campo produto vazio!", true, context);

      return;
    }

    if(_precoControler.text == ''){
      Mensagens().mensagem("Campo preço vazio!", true, context);

      return;
    }

    if(_quantidadeControler.text == ''){
      Mensagens().mensagem("Campo quantidade vazio!", true, context);

      return;
    }
    // adicionando informações da compra no banco de dados
    await db.collection("Usuários").doc(usuarioID.toString()).collection("Clientes")
      .doc(_idCliente).collection("Produtos").add({ 
      "Nome": nome,
      "Data": data,
      "Preço": preco,
      "Quantidade": quantidade,
      "Total": preco! * quantidade!,
      "Id": _qtdVenda + 1,
    });
    
    _atualizaDivida(preco, quantidade);

    // Atualizando informações sobre os ganhos do usuário
    await db.collection("Usuários").doc(usuarioID.toString()).update({ 
      "A Receber": _aReceber + (preco * quantidade),
      "Quantidade de Vendas": _qtdVenda + 1,
      "Vendido": _totalVendido + (preco * quantidade),
    });
    // Adicionando uma coleção que conta com informações sobre últimas vendas
    await db.collection("Usuários").doc(usuarioID).collection("Últimas Vendas").add({
      "Nome": widget.nome,
      "Produto": nome,
      "Preço": preco,
      "Id": _qtdVenda + 1, 
      "Cliente Id": _idCliente,
    });

    _proximaTela();
  }

  @override
  Widget build(BuildContext context) {

    void onChanged(String text){
      setState(() {

      });
    }

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
                // coluna com os input's de entrada de dados dos produtos comprados
                Column( 
                  children: [
                    InputFormulario(
                        label: "Produto",
                        hint: "Digite o nome do produto",
                        controller: _nomeControler,
                        onChanged: onChanged,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    InputFormulario(
                        label: "Preço",
                        hint: "Digite o preço, ex: 45.00",
                        controller: _precoControler,
                        onChanged: onChanged,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    InputFormulario(
                        label: "Quantidade",
                        hint: "Digite a quantidade comprada",
                        controller: _quantidadeControler,
                        onChanged: onChanged,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    InsereData(dataSelecionada: _data, onDateChanged: (novaData){
                      setState(() {
                        _data = novaData;
                      });
                    }),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Botao(
                        titulo: "Salvar",
                        desempilha: true,
                        funcaoGeral: _guardandoDados,
                    )
                  ],
                ), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}