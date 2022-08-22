import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskPreco extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){
    var preco = newValue.text;
    if (preco.length > 14) {
      return oldValue;
    }
    // desconsidera o que não é digito
    preco = preco.replaceAll(RegExp(r'\D'), '');
    var tamanho = preco.characters.length;

    var formatado = "";
    for (var i = 0; i < tamanho; i++){
        if (tamanho - 2 == i &&  tamanho > 2){
          formatado += "," ;
        }
        else if([1,4,7].contains(i) && [6,9,12].contains(tamanho)){
          formatado += '.';
        }
        else if([2,5,8].contains(i) && [7,10,13].contains(tamanho)){
          formatado += '.';
        }
        else if([3,6,9].contains(i) && [8,11,14].contains(tamanho)){
          formatado += '.';
        }

        formatado += preco[i];
    }

    return newValue.copyWith(
      text: formatado,
      selection: TextSelection.fromPosition(
          TextPosition(offset: formatado.length),
      ),
    );
  }
}