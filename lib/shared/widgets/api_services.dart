import 'package:dio/dio.dart';
import 'package:imdb/shared/widgets/movie_model.dart';

class MovieService {
  final Dio _dio = Dio();
  final String _apiKey = 'ff32759c';
  final String _baseUrl = 'http://www.omdbapi.com/';

  Future<List<MovieModel>> fetchMovies(String query) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'apikey': _apiKey, 's': query, 'page': 2},
      );

      if (response.data['Response'] == "True") {
        List list = response.data['Search'];
        final myList = list.map((m) => MovieModel.fromJson(m)).toList();
        final myFinalList = <MovieModel>[];
        for (final m in myList) {
          final film = await fetchMovieData(m.id);
          if (film != null) {
            myFinalList.add(film);
          }
        }
        return myFinalList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  Future<MovieModel?> fetchMovieData(String imdbID) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'apikey': _apiKey, 'i': imdbID},
      );

      if (response.data['Response'] == "True") {
        Map<String, dynamic> movieData = response.data;
        return MovieModel.fromJson(movieData);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to load movie of id $imdbID: $e');
    }
  }

  Future<MovieModel?> fetchTrendingHero() async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'apikey': _apiKey, 's': 'Dune'},
      );

      if (response.data['Response'] == "True") {
        List list = response.data['Search'];
        return MovieModel.fromJson(list[0]);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
