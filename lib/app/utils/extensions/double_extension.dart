import 'package:easy_localization/easy_localization.dart';

extension DoubleX on double {
  String toMoney() {
    final format =
        NumberFormat.simpleCurrency(locale: 'EN-us', decimalDigits: 2);
    String cur = format.format(this).toString();
    return cur;
  }
}
