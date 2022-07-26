import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/widgets/botao.dart';
import 'package:sales_manager/widgets/input_formulario.dart';
import 'package:sales_manager/screens/adicionar_produto.dart';
import 'package:sales_manager/util/mensagens.dart';

class AdicionarCliente extends StatefulWidget {
  const AdicionarCliente({Key? key}) : super(key: key);

  @override
  State<AdicionarCliente> createState() => _AdicionarClienteState();
}

class _AdicionarClienteState extends State<AdicionarCliente> {

  final _nomeControler = TextEditingController();
  final _bairroControler = TextEditingController();
  final _enderecoControler = TextEditingController();
  final _telefoneControler = TextEditingController();
  final db = FirebaseFirestore.instance;
  final usuarioID = FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

  void _proximaTela(String nome) async {

    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => AdicionarProduto(nome: nome)),
    );
  }

  _guardandoDados() async {
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
    // adicionando informações do cliente no banco de dados
    db.collection("Usuários").doc(usuarioID.toString()).collection("Clientes").add({ 
      "Nome": nome,
      "Bairro": bairro,
      "Endereço": endereco,
      "Telefone": telefone,
      "Saldo Devedor": 0.0
    });

    _proximaTela(nome);
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
                    const Text("Adicionar cliente", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                // Input's de adição dos dados do cliente no banco
                Column(
                  
                  children: [
                    InputFormulario(label: "Nome do Cliente", hint: "Digite o nome do cliente",controller: _nomeControler),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    InputFormulario(label: "Bairro", hint: "Digite o nome do bairro", controller: _bairroControler),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    InputFormulario(label: "Rua e N°", hint: "Digite o nome da rua e o número", controller: _enderecoControler),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    InputFormulario(label: "Telefone", hint: "Telefone", controller: _telefoneControler
                      , mascara: true, tipo: TextInputType.number
                      , acaoTeclado: false, salvandoDados: (_) => _guardandoDados()),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      
                    Botao(titulo: "Prosseguir", funcaoGeral: _guardandoDados)
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
