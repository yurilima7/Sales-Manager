class Cliente { 
  
  final String nome; 
  final String endereco; 
  final String bairro; 
  final String telefone; 
  
  Cliente({ 
    required this.nome, 
    required this.bairro, 
    required this.endereco, 
    required this.telefone, 
  }); 

  Map<String, dynamic> mapCliente(){ 
    return {
      "Nome": nome, 
      "Bairro": bairro, 
      "Endereço": endereco, 
      "Telefone": telefone, 
    };
  }
 }