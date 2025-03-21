import 'package:flutter/material.dart';
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
        final int movieId = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => MovieDetailsPage(movieId: movieId));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );
    }
  }
}
