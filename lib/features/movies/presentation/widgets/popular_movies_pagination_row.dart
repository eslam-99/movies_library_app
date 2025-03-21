import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/movie/movie_cubit.dart';

class PopularMoviesPaginationRow extends StatelessWidget {
  const PopularMoviesPaginationRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NumberPagination(
      buttonElevation: 2,
      buttonRadius: 5,
      selectedButtonColor: AppColors.primary,
      onPageChanged: (newPage) {
        if (context.read<MovieCubit>().state is! MovieLoading) {
          context.read<MovieCubit>().currentPage = newPage;
          context.read<MovieCubit>().fetchMovies();
        }
      },
      totalPages: context.read<MovieCubit>().totalPages,
      currentPage: context.read<MovieCubit>().currentPage,
      visiblePagesCount: ((MediaQuery.of(context).size.width - 200) / 75).round(),
      // visiblePagesCount: ((MediaQuery.of(context).size.width - 200) / 75).round(),
    );
  }
}
