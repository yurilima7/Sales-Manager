import 'package:flutter/material.dart';

class CardLista extends StatelessWidget {
  final String proximo;
  const CardLista({Key? key, required this.proximo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
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
                  
                  children: const [
                    Text("Marciano", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            
                    Text("R\$ 260", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    
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
