import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_library_app/core/theme/app_colors.dart';
import 'package:movies_library_app/features/movies/presentation/widgets/movie_card.dart';
import 'package:number_pagination/number_pagination.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../gen/assets.gen.dart';
import '../cubit/movie/movie_cubit.dart';
import '../widgets/popular_movies_pagination_row.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          return CustomScrollView(
            key: key,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Popular Movies',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  background: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: SvgPicture.asset(
                      Assets.images.tmdb,
                      color: AppColors.secondary,
                      // colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.dstOver),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                  child: const PopularMoviesPaginationRow(),
                ),
              ),
              if (state is MovieLoading)
                const SliverToBoxAdapter(child: AppLoading()),
              if (state is MovieLoaded)
              SliverPadding(
                padding: const EdgeInsets.all(12.0),
                sliver: SliverList.separated(
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieCard(movie: movie);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                ),
              ),
              if (state is MovieLoaded && state.movies.isEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const Center(
                      child: Text(
                        'No movies found',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              if (state is MovieLoaded && state.movies.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                  child: const PopularMoviesPaginationRow(),
                ),
              ),
            ],
          );
          // if (state is MovieLoading) {
          //   return const Center(child: AppLoading());
          // } else if (state is MovieLoaded) {
          // } else {
          //   return const Center(child: Text('Failed to load movies'));
          // }
        },
      ),
    );
  }
}
