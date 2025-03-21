import '../../../../../core/api/api_service.dart';
import '../../../domain/entities/movie_response.dart';
import '../../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponse> fetchPopularMovies(int page);

  Future<MovieModel> fetchMovieDetails(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiService _apiService;

  MovieRemoteDataSourceImpl(this._apiService);

  @override
  Future<MovieResponse> fetchPopularMovies(int page) async {
    final response = await _apiService.getMovies(page: page);
    return MovieResponse(
      movies:
          (response.data['results'] as List)
              .map<MovieModel>(
                (json) => MovieModel.fromJson(
                  json..addAll({'page': page, 'timestamp': DateTime.now().millisecondsSinceEpoch}),
                ),
              )
              .toList(),
      fromCache: false,
      totalPages: response.data['total_pages'],
    );
  }

  @override
  Future<MovieModel> fetchMovieDetails(int movieId) async {
    final response = await _apiService.getMovieDetails(movieId);
    return MovieModel.fromJson(response.data);
  }
}
