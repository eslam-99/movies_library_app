import 'package:movies_library_app/features/movies/domain/entities/movie_response.dart';

import '../entities/movie.dart';

abstract class MovieRepository {
  Future<MovieResponse> getPopularMovies(int page);
  Future<Movie> getMovieDetails(int movieId);
}
