import 'package:flutter/services.dart';

class Formatters {
  static toLower() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      return newValue.copyWith(
        text: newValue.text.toLowerCase(),
        selection: newValue.selection,
      );
    });
  }

  static formatDate(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}';
  }

  static formatDateMinimal(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  static formatDateApi(DateTime data) {
    return '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';
  }
}
