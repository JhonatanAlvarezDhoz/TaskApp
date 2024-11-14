import 'dart:developer';

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

  static DateTime? parseFormattedDateTime(String formattedDateTime) {
    try {
      DateFormat originalFormat = DateFormat('yyyy-MM-dd HH:mm');
      DateTime parsedDate = originalFormat.parse(formattedDateTime);

      return parsedDate;
    } catch (e) {
      log("Error: Formato de fecha y hora inválido eeee ::::  $e");
      return null;
    }
  }
}
