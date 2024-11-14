import 'package:flutter_test/flutter_test.dart';
import 'package:taskapp/helpers/formater.dart';

void main() {
  group('Formater', () {
    test('formatDateTime should format date correctly', () {
      final date = DateTime(2024, 3, 15, 10, 30);
      final result = Formater.formatDateTime(date);
      expect(result, '15-03-2024 10:30');
    });

    test('formatDateTime should handle invalid date', () {
      final date = DateTime.fromMicrosecondsSinceEpoch(0);
      final result = Formater.formatDateTime(date);
      expect(result, isA<String>());
    });

    test('parseFormattedDateTime should parse date correctly', () {
      const dateStr = '2024-03-15 10:30';
      final result = Formater.parseFormattedDateTime(dateStr);
      expect(result, isA<DateTime>());
      expect(result?.year, 2024);
      expect(result?.month, 3);
      expect(result?.day, 15);
      expect(result?.hour, 10);
      expect(result?.minute, 30);
    });

    test('parseFormattedDateTime should return null for invalid format', () {
      const dateStr = 'invalid-date';
      final result = Formater.parseFormattedDateTime(dateStr);
      expect(result, isNull);
    });
  });
}
