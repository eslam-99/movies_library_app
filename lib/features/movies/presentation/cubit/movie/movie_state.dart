part of 'movie_cubit.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final String? errMsg;
  MovieLoaded(this.movies, {this.errMsg});
}

class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}
