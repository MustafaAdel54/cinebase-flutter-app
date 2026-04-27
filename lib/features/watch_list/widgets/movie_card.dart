import 'package:flutter/material.dart';
import 'package:imdb/core/colors.dart';

class MovieCard extends StatelessWidget {
  final Map<String, dynamic> movieData;
  const MovieCard({super.key, required this.movieData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              // Poster Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  movieData['Poster'] ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Floating Star Rating
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.star, color: AppColors.primary, size: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movieData['Title'] ?? 'Unknown',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Text(
              '★ ${movieData['imdbRating']}',
              style: TextStyle(color: AppColors.primary, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
