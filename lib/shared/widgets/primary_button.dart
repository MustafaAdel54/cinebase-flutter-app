import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final Color labelColor;
  final IconData? icon;
  final bool showIcon;
  final Color? iconColor;
  final Color? backgroundColor;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.labelColor,
    this.icon,
    this.iconColor,
    this.showIcon = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) Icon(icon, color: iconColor),
            if (showIcon) SizedBox(width: 5),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: labelColor),
            ),
          ],
        ),
      ),
    );
  }
}

// class SignButtons extends StatelessWidget {
//   final String title;
//   final IconData icon;
//
//   const SignButtons({super.key, required this.title, required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton.icon(
//       onPressed: () {},
//       icon: Icon(
//         icon,
//         size: 30,
//         color: Theme.of(context).colorScheme.onSurface,
//       ),
//       label: Text(title, style: Theme.of(context).textTheme.titleMedium),
//     );
//   }
// }
