import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class LimitRange extends TextInputFormatter {
  var logger = Logger();
  LimitRange(
    this.minRange,
    this.maxRange,
  ) : assert(
          minRange < maxRange,
        );

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < minRange) {
      logger.d('Value Accepted');
      return TextEditingValue(text: minRange.toString());
    } else if (value > maxRange) {
      logger.d('Value Error Reseting Value');
      return TextEditingValue(text: maxRange.toString());
    }
    return newValue;
  }
}
