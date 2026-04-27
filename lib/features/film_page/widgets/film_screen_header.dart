import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb/core/colors.dart';
import 'package:imdb/shared/providers/favourite_provider.dart';
import 'package:imdb/shared/widgets/movie_model.dart';

class FilmScreenHeader extends ConsumerWidget {
  final String posterUrl;
  final MovieModel movie;
  const FilmScreenHeader({
    super.key,
    required this.posterUrl,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);
    final isFavorite = favorites.contains(movie.id);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(posterUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Theme.of(
                  context,
                ).scaffoldBackgroundColor.withValues(alpha: 0.1),
                Theme.of(context).scaffoldBackgroundColor,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          right: 20,
          child: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: AppColors.primary,
            onPressed: () {
              ref.read(favoriteProvider.notifier).toggleFavorite(movie.id, {
                'Title': movie.title,
                'Poster': movie.poster,
                'imdbRating': movie.rating,
              });
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
