import 'package:flutter/material.dart';

class ForYouSection extends StatelessWidget {
  final String imagePath;
  final String title;
  final String match;

  const ForYouSection({
    super.key,
    required this.imagePath,
    required this.title,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match,
                  style: const TextStyle(
                    color: Color(0xFFFFD740),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sci-Fi • 2h 44m",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                // Row(
                //   children: [
                //     _badge("4K"),
                //     const SizedBox(width: 8),
                //     _badge("HDR"),
                //   ],
                // ),
              ],
            ),
          ),
          const Icon(Icons.play_circle_fill, color: Colors.white54, size: 40),
        ],
      ),
    );
  }
}
