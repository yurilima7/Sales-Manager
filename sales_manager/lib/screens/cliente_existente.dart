import 'package:flutter/material.dart';
import 'package:sales_manager/components/card_lista.dart';
import 'package:sales_manager/components/pesquisa.dart';

class ClienteExistente extends StatefulWidget {
  const ClienteExistente({Key? key}) : super(key: key);

  @override
  State<ClienteExistente> createState() => _ClienteExistenteState();
}

class _ClienteExistenteState extends State<ClienteExistente> {
  void onChanged(String text){
    setState(() {
      //buscando = _pesquisa.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _pesquisa = TextEditingController();

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20), 

        child: Column(
        
          children: [
          
            Column(
            
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
            
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    const Text("Clientes", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Pesquisa(label: "Buscar Cliente", controller: _pesquisa, onChanged: onChanged),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              ],
            ),

            Expanded(
              
              child: ListView(
                
                children: const [
                  
                  CardLista(valor: 300, nome: "Marciano", id: "asndasi"),
                 
                ],
                
              ),
            )
          ],
        ),
      ),
    );
  }
}