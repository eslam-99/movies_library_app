import '../entities/movie.dart';
import '../entities/movie_response.dart';
import '../repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<MovieResponse> call(int page) async {
    return await repository.getPopularMovies(page);
  }
}
