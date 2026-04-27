import 'package:flutter/material.dart';

class GenreList extends StatelessWidget {
  final List<String> genres;
  const GenreList({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return _buildGenreChip(genres[index]);
        },
      ),
    );
  }
}

Widget _buildGenreChip(String label) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white12,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
