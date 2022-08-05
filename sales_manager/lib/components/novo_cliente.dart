import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/input_formulario.dart';
import 'package:sales_manager/screens/adicionar_produto.dart';

class NovoCliente extends StatefulWidget {
  final void Function(String, String, String, String)? guardaDados;

  const NovoCliente({Key? key, required this.guardaDados}) : super(key: key);

  @override
  State<NovoCliente> createState() => _NovoClienteState();
}

class _NovoClienteState extends State<NovoCliente> {
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

    widget.guardaDados!(nome, bairro, endereco, telefone);

    if(_nomeControler.text == '' && _bairroControler.text == '' && _enderecoControler.text == '' && _telefoneControler.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Todos os campos vazios!"),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    }

    if(_nomeControler.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Campo nome vazio!"),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    }

    if(_bairroControler.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Campo bairro vazio!"),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    }

    if(_enderecoControler.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Campo endereço vazio!"),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    }

    if(_telefoneControler.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Campo telefone vazio!"),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    }

    db.collection("Usuários").doc(usuarioID.toString()).collection("Clientes").add({ // adicionando informações do cliente no banco de dados
      "Nome": nome,
      "Bairro": bairro,
      "Endereço": endereco,
      "Telefone": telefone,
      "Saldo Devedor": 0.0
    });

    _proximaTela(nome);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
                  
      children: [
        InputFormulario(label: "Nome do Cliente", hint: "Digite o nome do cliente",controller: _nomeControler, funcaoPassada: (_) => _guardandoDados()),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        InputFormulario(label: "Bairro", hint: "Digite o nome do bairro", controller: _bairroControler, funcaoPassada: (_) => _guardandoDados()),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        InputFormulario(label: "Rua e N°", hint: "Digite o nome da rua e o número", controller: _enderecoControler, funcaoPassada: (_) => _guardandoDados()),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        InputFormulario(label: "Telefone", hint: "Digite o seu telefone", controller: _telefoneControler, funcaoPassada: (_) => _guardandoDados()),


        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          
        Botao(titulo: "Prosseguir", funcaoGeral: _guardandoDados)
      ],
    );
  }
}
