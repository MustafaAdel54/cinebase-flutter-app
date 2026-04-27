import 'package:flutter/material.dart';
import 'package:imdb/features/film_page/widgets/genre_list.dart';
import 'package:imdb/features/film_page/widgets/rating_badge.dart';

class FilmCategoryAndRating extends StatelessWidget {
  final String rating;
  final List<String> genres;
  const FilmCategoryAndRating({
    super.key,
    required this.rating,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          RatingBadge(score: rating),
          SizedBox(width: 10),
          Expanded(child: GenreList(genres: genres)),
        ],
      ),
    );
  }
}
