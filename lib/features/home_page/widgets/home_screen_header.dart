import 'package:flutter/material.dart';
import 'package:imdb/shared/widgets/api_services.dart';
import 'package:imdb/shared/widgets/movie_model.dart';
import 'package:imdb/shared/widgets/primary_button.dart';

class HomeScreenHeader extends StatefulWidget {
  const HomeScreenHeader({super.key});

  @override
  State<HomeScreenHeader> createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> {
  MovieModel? heroMovie;

  @override
  void initState() {
    super.initState();
    _loadHero();
  }

  void _loadHero() async {
    final movies = await MovieService().fetchMovies('Dune');
    setState(() {
      heroMovie = movies[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (heroMovie == null) {
      return const SizedBox(
        height: 450,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.network(
            heroMovie!.poster,
            height: 450,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 450,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withValues(alpha: 1)],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                  Text(
                    '${heroMovie!.rating}/10',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                heroMovie!.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                heroMovie!.plot,
                style: const TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Watch Trailer',
                      onPressed: () {},
                      labelColor: Colors.black,
                      showIcon: true,
                      icon: Icons.play_arrow,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      backgroundColor: Colors.white12,
                      label: 'Watchlist',
                      onPressed: () {},
                      labelColor: Colors.white,
                      showIcon: true,
                      icon: Icons.add,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
