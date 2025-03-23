import 'movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final bool fromCache;
  final bool cacheExpired;
  final String? errorMessage;

  const MovieResponse({
    required this.movies,
    required this.fromCache,
    this.cacheExpired = false,
    this.errorMessage,
  });
}
