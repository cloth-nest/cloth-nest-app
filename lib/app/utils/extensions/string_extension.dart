import 'package:easy_localization/easy_localization.dart';

extension StringX on String {
  String toMoney() {
    final format =
        NumberFormat.simpleCurrency(locale: 'EN-us', decimalDigits: 2);
    String cur = format.format(double.parse(this)).toString();
    return cur;
  }
}
