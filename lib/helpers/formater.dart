import 'package:intl/intl.dart';

class Formater {
  static String formatDateTime(DateTime date) {
    try {
      String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm').format(date);

      return formattedDateTime;
    } catch (e) {
      return "Error: Fecha u hora inválidas";
    }
  }
}
