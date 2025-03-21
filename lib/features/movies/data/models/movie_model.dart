import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class MovieModel extends Movie {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  final String releaseDate;

  @HiveField(4)
  final double voteAverage;

  @HiveField(5)
  final String posterPath;

  @HiveField(6)
  final List<String> genres;

  @HiveField(7)
  final int pageNo;

  @HiveField(8)
  final int timestamp;

  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.posterPath,
    required this.genres,
    required this.pageNo,
    required this.timestamp,
  }) : super(
          id: id,
          title: title,
          overview: overview,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          posterPath: posterPath,
          genres: genres,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      posterPath: json['poster_path'] ?? '',
      pageNo: json['page'] ?? 0,
      timestamp: json['timestamp'] ?? 0,
      genres: (json['genres'] as List<dynamic>?)?.map((g) => g['name']?.toString() ?? '').toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
