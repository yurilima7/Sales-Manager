import 'package:flutter/material.dart';
import 'package:sales_manager/screens/ficha_cliente.dart';

class CardCliente extends StatelessWidget {

  final String nome;
  final String telefone;
  final String bairro;
  final String rua;
  final double divida;
  final String id;
  final void Function(String, double) funcao;
  
  const CardCliente({Key? key, required this.nome, required this.telefone, required this.bairro
    , required this.rua, required this.divida, required this.id, required this.funcao}) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {

    _fichaCliente(){
      Navigator.push(
        context, 
        MaterialPageRoute<void>(builder: (BuildContext context) => 
          FichaCliente(idCliente: id, nome: nome, saldoDevedor: divida, bairro: bairro,
          rua: rua, telefone: telefone)),
      );
    }

    return GestureDetector(
      onTap: _fichaCliente,

      child: Card(
        color: const Color(0xFF6D3F8C),
        elevation: 3,
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        
        child: Container(

          padding: const EdgeInsets.all(10),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ListTile(

                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(nome, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        
                    IconButton(
                      onPressed: () => funcao(id, divida), 
                      alignment:  Alignment.topCenter,
                      icon: const Icon(Icons.delete, color: Colors.white),
                    ),
                  ],
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Divider(color: Colors.white),
                   
                    Text(telefone, style: const TextStyle(color: Colors.white, fontSize:  12)),
                    
                    Text(rua, style: const TextStyle(color: Colors.white, fontSize: 12)),
        
                    Text(bairro, style: const TextStyle(color: Colors.white, fontSize: 12)),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                      children: [
                        const Text("Saldo Devedor", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("R\$ $divida", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
