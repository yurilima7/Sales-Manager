import 'package:flutter/material.dart';
import 'package:sales_manager/components/novo_cliente.dart';
import 'package:sales_manager/models/cliente.dart';

class AdicionarCliente extends StatefulWidget {
  const AdicionarCliente({Key? key}) : super(key: key);

  @override
  State<AdicionarCliente> createState() => _AdicionarClienteState();
}

class _AdicionarClienteState extends State<AdicionarCliente> {

  final List <Cliente> _clientes = [];

  _addCliente(String nome, String bairro, String endereco, String telefone) {

    final novoCliente = Cliente(
      nome: nome,
      bairro: bairro,
      endereco: endereco,
      telefone: telefone,
    );

    setState(() {
      _clientes.add(novoCliente);
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
                    const Text("Adicionar cliente", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
          
                NovoCliente(guardaDados: _addCliente),
          
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
