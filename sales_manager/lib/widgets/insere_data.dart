import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InsereData extends StatelessWidget {
  final DateTime dataSelecionada;
  final Function(DateTime) onDateChanged;

  const InsereData({Key? key, required this.dataSelecionada, required this.onDateChanged}) : super(key: key);

  _adicionaData(BuildContext  context){
    // função responsável pela seleção da data
    showDatePicker(
      // retorna algo no futuro
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      // função que será chamada na seleção da data
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Expanded(

          child: Text(
            'Data Selecionada: ${DateFormat('dd/MM/y').format(dataSelecionada)}',
            style: const TextStyle(color: Color(0xFF6D3F8C), fontSize: 16)
          ),
        ),

        TextButton(
          onPressed: () => _adicionaData(context), 
          child: const Text(
            "Selecionar Data",
            style: TextStyle(color: Color(0xFF6D3F8C), fontSize: 16, fontWeight: FontWeight.bold),
          ))
      ],
    );
  }
}
