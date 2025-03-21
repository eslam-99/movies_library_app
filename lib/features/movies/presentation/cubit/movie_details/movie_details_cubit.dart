import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_movie_details.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetails getMovieDetails;

  MovieDetailsCubit(this.getMovieDetails) : super(MovieDetailsLoading());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movie = await getMovieDetails(movieId);
      emit(MovieDetailsLoaded(movie));
    } catch (e) {
      emit(MovieDetailsError('Failed to load movie details'));
    }
  }
}
