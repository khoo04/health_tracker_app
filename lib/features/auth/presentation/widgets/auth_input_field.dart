import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final Widget? prefixIcon;
  const AuthInputField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscureText = false,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
    );
  }
}
