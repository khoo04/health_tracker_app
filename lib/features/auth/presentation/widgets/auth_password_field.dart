import 'package:flutter/material.dart';

class AuthPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool isObscureText = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      // Trigger rebuild when the focus changes
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      obscureText: isObscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.lock),
        hintText: widget.hintText,
        labelText: widget.hintText,
        suffixIcon: _focusNode.hasFocus
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                icon: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "${widget.hintText} is missing!";
        }
        return null;
      },
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );
  }
}
