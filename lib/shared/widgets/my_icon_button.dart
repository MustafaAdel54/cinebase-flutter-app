import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  const MyIconButton({super.key, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFF1E1E1E),
        side: const BorderSide(color: Colors.white12, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(child: Icon(icon, color: color, size: 30)),
    );
  }
}
