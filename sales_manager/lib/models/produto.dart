class Produto  { 
   final String nome; 
   final double preco; 
   final int quantidade; 
   final String data ; 
  
   Produto({ 
     required this.nome, 
     required this.data, 
     required this.preco, 
     required this.quantidade, 
   }); 

   Map<String, dynamic> mapProduto(){ 
    return {
      "Nome": nome, 
      "Data": data, 
      "Preço": preco, 
      "Quantidade": quantidade, 
    };
  }
 }