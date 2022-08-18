import 'package:intl/intl.dart';

class FormatoNumero {
  
  String formatoBR(double valor){
    return NumberFormat.simpleCurrency(locale: 'pt_BR').format(valor);
  }
}