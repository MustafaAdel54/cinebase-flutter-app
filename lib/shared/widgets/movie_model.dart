class MovieModel {
  final String id;
  final String title;
  final String year;
  final String poster;
  final String plot;
  final String rating;
  final String? runTime;
  final List<String>? genres;
  final List<String>? actors;

  MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
    required this.rating,
    this.runTime,
    this.genres,
    this.actors,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    String genreString = json['Genre'] ?? "";
    List<String> genreList = genreString
        .split(',')
        .map((e) => e.trim())
        .toList();
    String actorsString = json['Actors'] ?? "";
    List<String> actorList = actorsString
        .split(',')
        .map((e) => e.trim())
        .toList();
    return MovieModel(
      id: json['imdbID'] ?? '',
      title: json['Title'] ?? 'No Title',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
      rating: json['imdbRating'] ?? '0.0',
      runTime: json['Runtime'] ?? '0.0',
      genres: genreList,
      actors: actorList,
    );
  }
}
