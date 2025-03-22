import 'package:flutter/material.dart';
import '../../features/movies/domain/entities/movie.dart';
import '../../features/movies/presentation/pages/movie_detail_page.dart';
import '../../features/movies/presentation/pages/movie_list_page.dart';

class Routes {
  static const String moviesList = '/';
  static const String movieDetails = '/movieDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case moviesList:
        return MaterialPageRoute(builder: (_) => const MovieListPage());

      case movieDetails:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(builder: (_) => MovieDetailsPage(movie: movie));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );
    }
  }
}
