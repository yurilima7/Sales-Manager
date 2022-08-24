import 'package:flutter/material.dart';
import 'package:sales_manager/screens/adicionar_cliente.dart';
import 'package:sales_manager/screens/cliente_existente.dart';
import 'package:sales_manager/widgets/botao.dart';

class OpcaoVenda extends StatelessWidget {
  const OpcaoVenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _addCliente(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const AdicionarCliente()),
      );
    }

    void _buscarExistente(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const ClienteExistente()),
      );
    }

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20),
        
        child: Column(

          children: [

            Expanded(
              flex: 1,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
            
                children: const [
                  Text("Adicionar venda", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            Expanded(
              flex: 9,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            
                  const Text("Venda para", style: TextStyle(color: Colors.black, fontSize: 16)),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
            
                      Botao(titulo: 'Novo Cliente', funcaoGeral: _addCliente),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      Botao(titulo: 'Cliente Existente', funcaoGeral: _buscarExistente),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
