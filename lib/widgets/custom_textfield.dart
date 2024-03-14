import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomTextField extends StatelessWidget {
  final String content;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onSubmited;
  const CustomTextField(
      {super.key,
      required this.content,
      this.onSaved,
      this.onSubmited,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onSaved: onSaved!,
      onFieldSubmitted: onSubmited,
      maxLength: 20,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ThemeClass().white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ThemeClass().white)),
          counterText: '',
          hintText: content),
    );
  }
}
