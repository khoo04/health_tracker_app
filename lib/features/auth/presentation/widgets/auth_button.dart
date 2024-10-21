import 'package:flutter/material.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  const AuthButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.primaryColor,
          foregroundColor: AppPallete.whiteColor,
          fixedSize: const Size(395, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
