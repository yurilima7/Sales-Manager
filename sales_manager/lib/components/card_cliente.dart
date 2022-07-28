import 'package:flutter/material.dart';

class CardCliente extends StatelessWidget {
  final String proximo;
  const CardCliente({Key? key, required this.proximo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF6D3F8C),
      elevation: 3,
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      
      child: ElevatedButton(

        onPressed: () { 
          Navigator.pushNamed(context, proximo);
        },

        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 3,
        ),

        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          
          child: Column(
            
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  const Text("Marciano", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          
                  IconButton(
                    onPressed: () => {}, 
                    
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
          
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("99-999994444", style: TextStyle(color: Colors.white, fontSize: 12, )),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      const Text("Avenida Central, N12", style: TextStyle(color: Colors.white, fontSize: 12)),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      const Text("Centro", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ],
              ),
          
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                children: const [
                  Text("Saldo Devedor", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("R\$ 260", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}