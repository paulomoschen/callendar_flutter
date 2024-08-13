import 'package:flutter/services.dart';
import 'dart:math' as math;

class TimeTextInputFormatter extends TextInputFormatter {
  TimeTextInputFormatter() {
    _exp = RegExp(r'^$|[0-9:]+$');
  }
  late RegExp _exp;

  final int hourMaxValue = 24;
  final int minuteMaxValue = 60;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    bool hasColon = oldValue.text.contains(':');
    int parseValue(String text) => int.tryParse(text) ?? 0;

    if (_exp.hasMatch(newValue.text)) {
      TextSelection newSelection = newValue.selection;

      final String value = newValue.text;
      String newText;

      String leftChunk = '';
      String rightChunk = '';

      if (value.length > 1 &&
          parseValue(value.substring(0, 2)) == hourMaxValue) {
        leftChunk =
            hasColon ? value.substring(0, 1) : '${value.substring(0, 2)}:';
        rightChunk = hasColon ? '' : '00';
      } else if (value.length > 5) {
        leftChunk = oldValue.text;
      } else if (value.length == 5) {
        leftChunk = (parseValue(value.substring(3)) > minuteMaxValue)
            ? oldValue.text
            : value;
      } else if (value.length == 2) {
        if (hasColon) {
          leftChunk = value.substring(0, 1);
        } else {
          if (parseValue(value) > hourMaxValue) {
            leftChunk = oldValue.text;
          } else {
            leftChunk = '${value.substring(0, 2)}:';
            rightChunk = value.substring(2);
          }
        }
      } else {
        leftChunk = value;
      }
      newText = leftChunk + rightChunk;

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(newText.length, newText.length),
        extentOffset: math.min(newText.length, newText.length),
      );

      return TextEditingValue(
        text: newText,
        selection: newSelection,
      );
    }
    return oldValue;
  }
}
