import 'package:imdb/shared/widgets/api_services.dart';
import 'package:imdb/shared/widgets/movie_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_provider.g.dart';

@riverpod
Future<MovieModel?> movieDetails(ref, String id) async {
  return MovieService().fetchMovieData(id);
}
