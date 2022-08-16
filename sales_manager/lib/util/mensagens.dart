import 'package:flutter/material.dart';

class Mensagens {

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mensagem
    (String mensagem, bool erro, BuildContext context){

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: erro? Colors.redAccent : Colors.greenAccent,
      )
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mensagemCronometrada
    (String mensagem, bool erro, BuildContext context){

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: erro? Colors.redAccent : Colors.greenAccent,
        duration: const Duration(seconds: 1),
      )
    );
  }
}