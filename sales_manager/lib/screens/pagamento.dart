import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/input_formulario.dart';
import 'package:sales_manager/screens/tap_bar_telas.dart';

class Pagamento extends StatefulWidget {
  final String nome, idCliente, idProduto;
  final double dividaCliente, totalCompra; // totalCompra é o preço do produto a ser pago
  
  const Pagamento({Key? key, required this.nome, required this.idCliente, 
        required this.idProduto, required this.dividaCliente, 
        required this.totalCompra}) 
        : super(key: key);

  @override
  State<Pagamento> createState() => _PagamentoState();
}

class _PagamentoState extends State<Pagamento> {
  final _valorDigitado = TextEditingController();
  late double _lucro = 0.0, _valorPago = 0.0;
  late double _aReceber = 0.0;

  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

  @override
  initState() {
    super.initState();
    _recebeDadosUsuario();
  }

  _recebeDadosUsuario() async {

    late double arrecadado;
    late double recebe;

    await db.collection("Usuários").doc(usuarioID.toString()).get().then((doc) => {
      if(doc.exists){
        arrecadado = doc.data()!["Lucro"],
        recebe = doc.data()!["A Receber"]
      }
    },);

    setState(() {
      _lucro = arrecadado;
      _aReceber = recebe;
    });
  } 

   void _proximaTela() async {

    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => const PercorreTelas()),
      (route) => false,
    );
  }
  // atualiza os dados dos clientes e do usuário
  void _atualizaPosPagamento(double valorPago) async{
    await db.collection("Usuários").doc(usuarioID).collection("Clientes")
          .doc(widget.idCliente).update({
            "Saldo Devedor": widget.dividaCliente - valorPago,
          });

    await db.collection("Usuários").doc(usuarioID).update({
            "A Receber": _aReceber - valorPago,
            "Lucro": _lucro + valorPago
          });

    _proximaTela();
  }

  _pagamento() async{
    // caso o valor pago seja igual o preço do total da compra, o debito é quitado
    if(_valorPago == widget.totalCompra){ 
      await db.collection("Usuários").doc(usuarioID).collection("Clientes")
            .doc(widget.idCliente).collection("Produtos").doc(widget.idProduto)
            .delete();

      _atualizaPosPagamento(_valorPago);
    }// caso não seja igual ao valor e o valor seja válido
    else if(_valorPago < widget.totalCompra && _valorPago > 0.0){
      await db.collection("Usuários").doc(usuarioID).collection("Clientes")
            .doc(widget.idCliente).collection("Produtos").doc(widget.idProduto)
            .update({
              "Total": widget.totalCompra - _valorPago,
            });

     _atualizaPosPagamento(_valorPago);
    }// caso o valor não seja válido mensagem de erro
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Não foi possivel pagar, tente novamente!"),
          backgroundColor: Colors.redAccent,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // atualiza o valor do pagamento
    void onChanged(String text){
      setState(() {
        _valorPago = double.tryParse(_valorDigitado.text)!;
      });
    }
    
    return Scaffold(

      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

        child: Padding(
          padding: const EdgeInsets.all(20),
      
          child: Column(
            
            children: [
          
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
              
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  const Text("Pagamento", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
          
              Expanded(
               
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputFormulario(label: "Digite o valor", hint: "Ex: 25.00",acaoTeclado: false, controller: _valorDigitado, onChanged: onChanged),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Botao(titulo: "Pagar", funcaoGeral: _pagamento)
                  ],
                ),
              ),
      
             
            ],
          ),
        ),
      ),
    );
  }
}