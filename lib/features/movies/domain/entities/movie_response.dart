import 'movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final bool fromCache;
  final int? totalPages;
  final String? errorMessage;

  const MovieResponse({
    required this.movies,
    required this.fromCache,
    this.totalPages,
    this.errorMessage,
  });
}
