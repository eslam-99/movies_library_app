import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../injection_container.dart';
import '../cubit/movie_details/movie_details_cubit.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<MovieDetailsCubit>()..fetchMovieDetails(movieId);
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Details')),
      body: BlocProvider<MovieDetailsCubit>(
        create: (context) => cubit,
        child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(child: AppLoading());
            } else if (state is MovieDetailsLoaded) {
              final movie = state.movie;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Release Date: ${movie.releaseDate}"),
                    const SizedBox(height: 8),
                    Text("Rating: ${movie.voteAverage}"),
                    const SizedBox(height: 8),
                    Text("Genres: ${movie.genres.join(', ')}"),
                    const SizedBox(height: 8),
                    Text(movie.overview),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Failed to load details'));
            }
          },
        ),
      ),
    );
  }
}
