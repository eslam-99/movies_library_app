import '../../../../core/config/app_contants.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_response.dart';
import '../../domain/repositories/movie_repository.dart';
import '../data_sources/local/movie_local_datasource.dart';
import '../data_sources/remote/movie_remote_datasource.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<MovieResponse> getPopularMovies(int page) async {
    final cachedMovies = await localDataSource.getMoviesByPage(page);
    final isExpired =
        cachedMovies.isNotEmpty &&
        DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(cachedMovies.firstOrNull?.timestamp ?? 0))
                .inMilliseconds >
            AppConstants.cachingTimeout;
    if (isExpired) {
      await localDataSource.removeMoviesByPage(page);
    }
    if (cachedMovies.isNotEmpty) {
      return MovieResponse(movies: cachedMovies, fromCache: true, cacheExpired: isExpired);
    }

    if (await networkInfo.isConnected) {
      try {
        final moviesResponse = await remoteDataSource.fetchPopularMovies(page);
        await localDataSource.cacheMovies(moviesResponse.movies as List<MovieModel>);
        return moviesResponse;
      } catch (e) {
        return MovieResponse(movies: cachedMovies, fromCache: true, errorMessage: 'Error Getting Movies from Server');
      }
    } else {
      return MovieResponse(
        movies: cachedMovies,
        fromCache: true,
        errorMessage: 'Make sure you have an active internet connection',
      );
    }
  }

  @override
  Future<Movie> getMovieDetails(int movieId) async {
    // return await remoteDataSource.fetchMovieDetails(movieId);

    final cachedMovie = await localDataSource.getMovieById(movieId);

    if (cachedMovie != null) {
      if (cachedMovie.genres.isNotEmpty) {
        return cachedMovie;
      } else {
      }
    }

    if (await networkInfo.isConnected) {
      try {
        final movie = await remoteDataSource.fetchMovieDetails(movieId);
        await localDataSource.updateCachedMovieGenres(movie);
        return movie;
      } catch (e) {
        throw 'Error Getting Movies from Server';
      }
    } else {
      throw 'Make sure you have an active internet connection';
    }
  }
}
