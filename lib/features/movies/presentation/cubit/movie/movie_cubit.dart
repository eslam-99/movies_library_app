import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetPopularMovies getPopularMovies;

  MovieCubit(this.getPopularMovies) : super(MovieInitial());

  int currentPage = 1;
  int totalPages = 49288;

  Future<void> fetchMovies({int? page}) async {
    emit(MovieLoading());
    try {
      page = page ?? currentPage;
      final moviesResponse = await getPopularMovies(page);
      totalPages = moviesResponse.totalPages ?? totalPages;
      emit(MovieLoaded(moviesResponse.movies, errMsg: moviesResponse.errorMessage));
      if (moviesResponse.cacheExpired) {
        await Future.delayed(const Duration(milliseconds: 1));
        final moviesResponse = await getPopularMovies(page);
        totalPages = moviesResponse.totalPages ?? totalPages;
        if (page == currentPage) {
          currentPage = page;
          emit(MovieLoaded(moviesResponse.movies, errMsg: moviesResponse.errorMessage));
        }
      }
    } catch (e) {
      emit(MovieError('Failed to load movies'));
    }
  }
}
