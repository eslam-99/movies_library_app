import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheMovies(List<MovieModel> movies);
  Future<void> updateCachedMovieGenres(MovieModel movie);
  Future<List<MovieModel>> getMoviesByPage(int page);
  Future<MovieModel?> getMovieById(int id);
  Future<void> removeMoviesByPage(int page);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final Box<MovieModel> movieBox;

  MovieLocalDataSourceImpl(this.movieBox);

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    try {
      await movieBox.addAll(movies);
    } catch (e) {
      throw CacheException('Failed to cache movies');
    }
  }

  @override
  Future<void> updateCachedMovieGenres(MovieModel movie) async {
    try {
      final cachedMovieKey = await movieBox.keys.firstWhereOrNull((m) => movieBox.get(m)?.id == movie.id);
      if (cachedMovieKey != null) {
        final cachedMovie = movieBox.get(cachedMovieKey);
        await movieBox.delete(cachedMovieKey);
        await movieBox.put(cachedMovieKey, cachedMovie!.copyWith(genres: movie.genres));
      }
    } catch (e) {
      throw CacheException('Failed to cache movies');
    }
  }

  @override
  Future<List<MovieModel>> getMoviesByPage(int page) async {
    return movieBox.values.where((m) => m.pageNo == page).toList();
  }

  @override
  Future<void> removeMoviesByPage(int page) async {
    final moviesToRemove = movieBox.keys.where((k) => (movieBox.get(k))?.pageNo == page).toList();
    for (var movieKey in moviesToRemove) {
      await movieBox.delete(movieKey);
    }
  }

  @override
  Future<MovieModel?> getMovieById(int id) async {
    return movieBox.values.firstWhereOrNull((m) => m.id == id);
  }
}
