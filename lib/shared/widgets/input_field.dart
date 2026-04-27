import 'package:flutter/material.dart';
import 'package:imdb/core/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final bool isObscure;
  final Widget? suffix;
  final void Function(String)? onChange;
  final Widget? prefixIcon;

  const InputField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText,
    this.suffix,
    this.isObscure = false,
    this.onChange,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.grey.shade800), // Very rounded
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: AppColors.textPrimary),
        ),
        suffixIcon: suffix,
      ),
      obscureText: isObscure,
      controller: controller,
      onChanged: onChange,
      validator: validator,
    );
  }
}
