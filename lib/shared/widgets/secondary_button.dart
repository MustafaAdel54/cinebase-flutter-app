import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final Color labelColor;
  final dynamic fontWeight;
  final dynamic fontSize;
  final IconData? icon;
  final bool showIcon;
  final VoidCallback onPressed;
  final double? iconSize;
  final Color iconColor;
  final Color borderColor;

  const SecondaryButton({
    super.key,
    required this.label,
    this.icon,
    this.iconColor = Colors.white,
    required this.onPressed,
    this.showIcon = false,
    this.iconSize = 40.0,
    this.labelColor = Colors.white,
    this.fontSize = 20.0,
    this.fontWeight = FontWeight.w500,
    this.borderColor = Colors.white12,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFF1E1E1E),
        side: BorderSide(color: borderColor, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon) Icon(icon, size: iconSize, color: iconColor),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
