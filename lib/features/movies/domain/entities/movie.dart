import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final String posterPath;
  final List<String> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.posterPath,
    required this.genres,
  });

  @override
  List<Object?> get props => [id, title, overview, releaseDate, voteAverage, posterPath, genres];
}
