import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../cubit/movie/movie_cubit.dart';
import 'movie_card.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      key: GlobalKey(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie).animate(
          effects: [
            MoveEffect(
              begin: Offset(
                MediaQuery.of(context).size.width *
                    -1 *
                    (index % 2 == 0 ? 1 : -1) *
                    (context.read<MovieCubit>().currentPage % 2 == 0 ? 1 : -1),
                0,
              ),
              end: const Offset(0, 0),
              duration: const Duration(milliseconds: 300),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
