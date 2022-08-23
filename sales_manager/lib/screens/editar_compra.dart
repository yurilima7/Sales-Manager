import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/screens/principal.dart';
import 'package:sales_manager/util/formato_numero.dart';
import 'package:sales_manager/widgets/botao.dart';
import 'package:sales_manager/widgets/editar_dados.dart';
import 'package:sales_manager/widgets/insere_data.dart';
import 'package:sales_manager/util/mensagens.dart';

class EditarCompra extends StatefulWidget {

  final String nome, idProduto, idCliente, idUsuario ;
  final DateTime data;
  final double preco, saldoDevedor, totalAtual;
  final int quantidadeAnterior, idVenda;

  const EditarCompra({Key? key, required this.nome, required this.data, 
    required this.idProduto, required this.idCliente, 
    required this.idUsuario, required this.preco, 
    required this.quantidadeAnterior, required this.saldoDevedor,
    required this.idVenda, required this.totalAtual}) : super(key: key);

  @override
  State<EditarCompra> createState() => _EditarCompraState();
}

class _EditarCompraState extends State<EditarCompra> {

  final _nomeControler = TextEditingController();
  late DateTime _data;
  final _precoControler = TextEditingController();
  final _quantidadeControler = TextEditingController();
  final db = FirebaseFirestore.instance;
  late double _aReceber, _totalVendido;

  @override
  initState() {
    super.initState();
    _inicializaData();
    _recebeLucro();
  }

  _inicializaData(){
    setState(() {
      _data = widget.data;
    });
  }

  _recebeLucro() async{
    late double val, vendido;

    await db.collection("Usuários").doc(widget.idUsuario).get().then((doc) => {
      if(doc.exists){
        val = (doc.data()!["A Receber"]) as double,
        vendido = (doc.data()!["Vendido"]) as double,
      }
    },);

    setState(() {
      _aReceber = val;
      _totalVendido = vendido;
    });

  }

  @override
  void dispose(){
    _nomeControler.dispose();
    _precoControler.dispose();
    _quantidadeControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void _proximaTela() async {

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => 
          const Principal()
      ),(route) => false,);
    }

    _editandoDados() async {
      final nome = _nomeControler.text;
      final data = _data;
      final preco = double.tryParse(_precoControler.text.replaceAll(',', '.'));
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

      await db.collection("Usuários").doc(widget.idUsuario).collection("Clientes")
        .doc(widget.idCliente).collection("Produtos").doc(widget.idProduto).update({ // atualizando informações do produto no banco de dados
        "Nome": nome,
        "Data": data,
        "Quantidade": quantidade,
        "Preço": preco,
        "Total": widget.totalAtual + ((preco! * quantidade!) - (widget.preco * widget.quantidadeAnterior)),
      });

      await db.collection("Usuários").doc(widget.idUsuario).collection("Clientes")
        .doc(widget.idCliente).update({
          "Saldo Devedor": (widget.saldoDevedor - (widget.preco * widget.quantidadeAnterior)) + preco * quantidade,
      });

      await db.collection("Usuários").doc(widget.idUsuario).update({
        "A Receber": (_aReceber - (widget.preco * widget.quantidadeAnterior)) + preco * quantidade,
        "Vendido": (_totalVendido  - (widget.preco * widget.quantidadeAnterior)) + preco * quantidade,
      });

            
      await db.collection("Usuários").doc(widget.idUsuario).collection("Últimas Vendas").orderBy("Id", descending: true).get()
      .then((QuerySnapshot snapshot) => {
        for(var doc in snapshot.docs){
  
          if(doc["Id"] == widget.idVenda){
            db.collection("Usuários").doc(widget.idUsuario).collection("Últimas Vendas")
            .doc(doc.id).update({
              "Produto": nome,
              "Preço": preco,
            }),
          }
        }
      });

      _proximaTela();
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
                    const Text("Editar compra", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
          
                Column(
                  
                  children: [
                    EditarDados(nome: widget.nome, texto: _nomeControler),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    EditarDados(nome: FormatoNumero().formatoBR(widget.preco), texto: _precoControler, 
                      mascara: true, maskPreco: true, tipo: TextInputType.number),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    EditarDados(nome: widget.quantidadeAnterior.toString(), 
                      texto: _quantidadeControler, tipo: TextInputType.number,
                      salvandoDados: (_) => _editandoDados(), acaoTeclado: false),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    InsereData(dataSelecionada: _data, onDateChanged: (novaData){
                      setState(() {
                        _data = novaData;
                      });
                    }),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          
                Botao(titulo: "Salvar", desempilha: true, funcaoGeral: _editandoDados)
              ],
            ),
          ),
        ),
      ),
    );
  }
}