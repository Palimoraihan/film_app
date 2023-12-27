import 'package:flutter/material.dart';

extension BuildContextExstension on BuildContext {
  void showSnacBar(String mesaage) => ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(mesaage)));
}
