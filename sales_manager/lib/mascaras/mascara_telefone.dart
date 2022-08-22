import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskTelefone extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){
    var telefone = newValue.text;
    if (telefone.length > 15) {
      return oldValue;
    }
    // desconsidera o que não é digito
    telefone = telefone.replaceAll(RegExp(r'\D'), ''); 
    var tamanho = telefone.characters.length;

    var formatado = "";
    for (var i = 0; i < tamanho; i++){

      if(i == 0){
        formatado += '(';
      }
      else if(i == 2){
        formatado += ') ';
      }
      else if(i == 7){
        formatado += '-';
      }
  
      formatado += telefone[i];
    }
    
    return newValue.copyWith(
      text: formatado,
      selection: TextSelection.fromPosition(
          TextPosition(offset: formatado.length),
      ),
    );
  }
}