import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb/shared/widgets/api_services.dart';
import 'package:imdb/shared/widgets/movie_model.dart';

class MovieSection extends StatelessWidget {
  final String category;
  const MovieSection({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    String searchQuery = category == "All" ? "Movie" : category;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Trending Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add your navigation logic here
                  print("See all tapped");
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Removes default internal padding
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize
                      .shrinkWrap, // Shrinks the hit area to the text
                ),
                child: const Text(
                  "See all",
                  style: TextStyle(
                    color: Color(0xFFFFD740), // Your MDB Yellow
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        FutureBuilder<List<MovieModel>>(
          future: MovieService().fetchMovies(searchQuery),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            final movies = snapshot.data ?? [];
            return SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return InkWell(
                    onTap: () {
                      context.push('/filmScreen/${movie.id}');
                    },
                    child: Container(
                      width: 130,
                      margin: const EdgeInsets.only(left: 16),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              movie.poster,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
