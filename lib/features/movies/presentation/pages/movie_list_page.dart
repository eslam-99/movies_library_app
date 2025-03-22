import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_library_app/core/utils/toast.dart';
import '../../../../core/widgets/loading.dart';
import '../cubit/movie/movie_cubit.dart';
import '../widgets/movie_list.dart';
import '../widgets/no_movies_widget.dart';
import '../widgets/popular_movies_app_bar.dart';
import '../widgets/popular_movies_pagination_row.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0),
      body: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {
          if (state is MovieLoaded && state.errMsg != null) {
            AppToast.showToastyBox(context: context, msg: state.errMsg!, type: AppToastType.error);
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            slivers: [
              const PopularMoviesAppBar(),
              if (state is MovieLoaded)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                    child: PopularMoviesPaginationRow(
                      key: GlobalKey(),
                      onPageChange: (page) {
                        controller.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                      },
                    ),
                  ),
                ),
              if (state is MovieLoading)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenHeight * 0.6,
                    child: const Center(child: AppLoading()),
                  ),
                ),
              if (state is MovieLoaded && state.movies.isNotEmpty)
                SliverPadding(padding: const EdgeInsets.all(12.0), sliver: MovieList(movies: state.movies)),
              if (state is MovieLoaded && state.movies.isEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenHeight * 0.6,
                    child: const NoMoviesWidget(),
                  ),
                ),
              if (state is MovieLoaded && state.movies.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                    child: PopularMoviesPaginationRow(
                      key: GlobalKey(),
                      onPageChange: (page) {
                        controller.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
