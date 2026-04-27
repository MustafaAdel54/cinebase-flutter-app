import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb/core/colors.dart';
import 'package:imdb/features/film_page/widgets/actor_card.dart';
import 'package:imdb/features/film_page/widgets/film_category_and_rating.dart';
import 'package:imdb/features/film_page/widgets/film_screen_header.dart';
import 'package:imdb/shared/providers/movie_provider.dart';
import 'package:imdb/shared/widgets/primary_button.dart';
import 'package:imdb/shared/widgets/secondary_button.dart';

class FilmScreen extends ConsumerWidget {
  final String imdbID;
  const FilmScreen({super.key, required this.imdbID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailsProvider(imdbID));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: movieAsync.when(
        data: (movie) {
          if (movie == null) {
            return const Center(child: Text("Movie not found"));
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                FilmScreenHeader(movie: movie, posterUrl: movie.poster),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            movie.year,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          SizedBox(width: 10, child: Text(' .')),
                          Text(
                            movie.runTime!,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      FilmCategoryAndRating(
                        rating: movie.rating,
                        genres: movie.genres!,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.plot,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'Top Cast',
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          InkWell(
                            child: Text(
                              'see all >',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ActorCard(actors: movie.actors!),
                      SizedBox(height: 30),
                      PrimaryButton(
                        label: 'watch trailer',
                        onPressed: () {},
                        labelColor: AppColors.background,
                        showIcon: true,
                        icon: Icons.play_arrow,
                      ),
                      SizedBox(height: 15),
                      SecondaryButton(
                        label: 'add to watchlist',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFFFD740)),
        ),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
