part of 'movie_details_cubit.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final Movie movie;
  MovieDetailsLoaded(this.movie);
}

class MovieDetailsError extends MovieDetailsState {
  final String errMsg;
  MovieDetailsError(this.errMsg);
}
