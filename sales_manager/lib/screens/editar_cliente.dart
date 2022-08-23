import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/screens/principal.dart';
import 'package:sales_manager/widgets/botao.dart';
import 'package:sales_manager/widgets/editar_dados.dart';
import 'package:sales_manager/util/mensagens.dart';

class EditarCliente extends StatefulWidget {
  final String nome, bairro, rua, telefone, idCliente; 
  final double divida;

  const EditarCliente({Key? key, required this.nome, required this.bairro, 
    required this.rua, required this.telefone, required this.idCliente, required this.divida}) : super(key: key);

  @override
  State<EditarCliente> createState() => _EditarClienteState();
}

class _EditarClienteState extends State<EditarCliente> {
  final _nomeControler = TextEditingController();
  final _bairroControler = TextEditingController();
  final _enderecoControler = TextEditingController();
  final _telefoneControler = TextEditingController();
  final db = FirebaseFirestore.instance;
  final usuarioID = FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

  void _proximaTela(String nome, String idCliente, double saldoDevedor, String bairro, String rua, String telefone) async {

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => 
          const Principal()),(route) => false,
      );
    }

    _editandoDados() async {
      final nome = _nomeControler.text;
      final bairro = _bairroControler.text;
      final endereco = _enderecoControler.text;
      final telefone = _telefoneControler.text;

      if(_nomeControler.text == '' && _bairroControler.text == '' && _enderecoControler.text == '' && _telefoneControler.text == ''){
        Mensagens().mensagem("Todos os campos vazios!", true, context);

        return;
      }

      if(_nomeControler.text == ''){
        Mensagens().mensagem("Campo nome vazio!", true, context);

        return;
      }

      if(_bairroControler.text == ''){
        Mensagens().mensagem("Campo bairro vazio!", true, context);

        return;
      }

      if(_enderecoControler.text == ''){
        Mensagens().mensagem("Campo endereço vazio!", true, context);

        return;
      }

      if(_telefoneControler.text == ''){
        Mensagens().mensagem("Campo telefone vazio!", true, context);

        return;
      }

      await db.collection("Usuários").doc(usuarioID.toString()).collection("Clientes")
        .doc(widget.idCliente).update({ // atualizando informações do cliente no banco de dados
        "Nome": nome,
        "Bairro": bairro,
        "Endereço": endereco,
        "Telefone": telefone,
        "Saldo Devedor": widget.divida
      });

      await db.collection("Usuários").doc(usuarioID).collection("Últimas Vendas").orderBy("Id", descending: true).get()
      .then((QuerySnapshot snapshot) => {
        for(var doc in snapshot.docs){
  
          if(doc["Cliente Id"] == widget.idCliente){
            db.collection("Usuários").doc(usuarioID).collection("Últimas Vendas")
            .doc(doc.id).update({
              "Nome": nome,
            }),
          }
        }
      });

      _proximaTela(nome, widget.idCliente, widget.divida , bairro, endereco, telefone);
    }

    @override
    void dispose(){
      _nomeControler.dispose();
      _bairroControler.dispose();
      _enderecoControler.dispose();
      _telefoneControler.dispose();
      super.dispose();
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
                    const Text("Editar cliente", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
          
                Column(
                  
                  children: [
                    EditarDados(nome: widget.nome, texto: _nomeControler),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    EditarDados(nome: widget.bairro, texto: _bairroControler),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    EditarDados(nome: widget.rua, texto: _enderecoControler),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    EditarDados(nome: widget.telefone, texto: _telefoneControler, 
                      mascara: true, tipo: TextInputType.number, 
                      salvandoDados: (_) => _editandoDados(), acaoTeclado: false),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          
                Botao(
                  titulo: "Salvar", 
                  funcaoGeral: _editandoDados,
                  desempilha: true,
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}