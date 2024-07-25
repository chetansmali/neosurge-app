import 'package:intl/intl.dart';

extension CurrencyString on String {
  double get removeCommas => double.parse(replaceAll(',', ''));
}

extension CurrencyDouble on double {
  String toCurrency({int? decimalDigits}) => NumberFormat.currency(
          locale: 'en_IN', symbol: '', decimalDigits: decimalDigits ?? 0)
      .format(this);

  String toCurrencyWithSymbol({int? decimalDigits}) => NumberFormat.currency(
          locale: 'en_IN', symbol: '₹', decimalDigits: decimalDigits ?? 0)
      .format(this);
}

extension StringExtension on String {
  String get capitalize => "${this[0].toUpperCase()}${substring(1)}";
}
