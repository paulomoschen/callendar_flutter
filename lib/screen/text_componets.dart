import 'package:flutter/material.dart';

inputDecoration({required String label, String? hintText}) {
  return InputDecoration(
    label: Text(label),
    hintText: hintText,
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7))),
    alignLabelWithHint: true,
    filled: true,
  );
}
