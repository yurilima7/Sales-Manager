import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';

class OpcaoVenda extends StatelessWidget {
  const OpcaoVenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            
                      const Botao(titulo: 'Novo Cliente', proxima: "/addCliente"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      const Botao(titulo: 'Cliente Existente', proxima: "/clienteExistente"),
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
