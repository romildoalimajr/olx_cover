import 'package:flutter/material.dart';

class InputCustomizado extends StatelessWidget {

  late final TextEditingController controller;
  late final String hint;
  late final bool obscure;
  late final bool autoFocus;
  late final TextInputType type;

  InputCustomizado({
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.autoFocus = false,
    this.type = TextInputType.text
});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      autofocus: this.autoFocus,
      obscureText: this.obscure,
      keyboardType: this.type,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        hintText: this.hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
