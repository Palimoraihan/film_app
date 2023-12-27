import 'package:film_app/presentations/misc/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obsecureText;
  const CustomeTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obsecureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade800)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: ghostWhite))
      ),
    );
  }
}
