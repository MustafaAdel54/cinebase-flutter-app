import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb/shared/providers/obsecure_provider.dart';
import 'package:imdb/shared/widgets/input_field.dart';

class PasswordInputField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final void Function()? onPressed;
  final void Function(String)? onChange;

  const PasswordInputField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText,
    this.onPressed,
    this.onChange,
  });
  @override
  ConsumerState<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends ConsumerState<PasswordInputField> {
  @override
  Widget build(BuildContext context) {
    final isObscured = ref.watch(obscureTextProvider);

    return InputField(
      controller: widget.controller,
      onChange: widget.onChange,
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().length < 5) {
          return 'please enter valid Password';
        } else {
          return null;
        }
      },
      hintText: widget.hintText ?? 'Enter your password',
      isObscure: isObscured,
      suffix: IconButton(
        icon: Icon(
          isObscured
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
        onPressed:
            widget.onPressed ??
            () {
              ref.read(obscureTextProvider.notifier).state = !isObscured;
            },
      ),
    );
  }
}
