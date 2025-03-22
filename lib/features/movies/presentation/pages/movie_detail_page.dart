import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_library_app/core/utils/toast.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/movie.dart';
import '../cubit/movie_details/movie_details_cubit.dart';
import '../widgets/movie_details_app_bar.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    final cubit = sl<MovieDetailsCubit>()..fetchMovieDetails(movie.id);
    Movie? movieData;
    return Scaffold(
      // appBar: AppBar(toolbarHeight: 0.0),
      body: BlocProvider<MovieDetailsCubit>(
        create: (context) => cubit,
        child: BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
          listener: (context, state) {
            if (state is MovieDetailsError) {
              AppToast.showToastyBox(context: context, msg: state.errMsg, type: AppToastType.error);
            }
          },
          builder: (context, state) {
            if (state is MovieDetailsLoaded) {
              movieData = state.movie;
            }
            return CustomScrollView(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              slivers: [
                MovieDetailsAppBar(title: movie.title, poster: movie.posterPath),
                if (state is MovieDetailsLoading)
                  SliverToBoxAdapter(
                    child: SizedBox(height: screenHeight * 0.3, child: const Center(child: AppLoading())),
                  ),
                if (state is MovieDetailsLoaded)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movieData!.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Release Date: ${movieData!.releaseDate}'),
                          const SizedBox(height: 8),
                          Text('Rating: ⭐ ${movieData!.voteAverage}'),
                          const SizedBox(height: 8),
                          Text('Genres: ${movieData!.genres.join(', ')}'),
                          const SizedBox(height: 8),
                          Text(movieData!.overview),
                        ],
                      ),
                    ),
                  ),
              ],
            );
            // if (state is MovieDetailsLoading) {
            //   return const Center(child: AppLoading());
            // } else if (state is MovieDetailsLoaded) {
            //   final movie = state.movie;
            //   return Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(movie.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            //         const SizedBox(height: 8),
            //         Text("Release Date: ${movie.releaseDate}"),
            //         const SizedBox(height: 8),
            //         Text("Rating: ${movie.voteAverage}"),
            //         const SizedBox(height: 8),
            //         Text("Genres: ${movie.genres.join(', ')}"),
            //         const SizedBox(height: 8),
            //         Text(movie.overview),
            //       ],
            //     ),
            //   );
            // } else {
            //   return const Center(child: Text('Failed to load details'));
            // }
          },
        ),
      ),
    );
  }
}
