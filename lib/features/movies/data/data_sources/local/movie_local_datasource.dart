import 'package:hive/hive.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheMovies(List<MovieModel> movies);
  Future<List<MovieModel>> getMoviesByPage(int page);
  Future<void> removeMoviesByPage(int page);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final Box<MovieModel> movieBox;

  MovieLocalDataSourceImpl(this.movieBox);

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    try {
      // await movieBox.clear();
      await movieBox.addAll(movies);
    } catch (e) {
      throw CacheException('Failed to cache movies');
    }
  }

  @override
  Future<List<MovieModel>> getMoviesByPage(int page) async {
    return movieBox.values.where((m) => m.pageNo == page).toList();
    // if (movieBox.isNotEmpty) {
    // } else {
    //   throw CacheException('No cached movies found');
    // }
  }

  @override
  Future<void> removeMoviesByPage(int page) async {
    final moviesToRemove = movieBox.keys.where((k) => (movieBox.get(k))?.pageNo == page).toList();
    // final moviesToRemove = movieBox.values.where((m) => m.pageNo == page).toList();
    for (var movieKey in moviesToRemove) {
      await movieBox.delete(movieKey);
    }
  }
}
