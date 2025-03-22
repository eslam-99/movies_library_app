import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_library_app/core/theme/app_colors.dart';
import 'package:number_paginator/number_paginator.dart';
import '../cubit/movie/movie_cubit.dart';

class PopularMoviesPaginationRow extends StatefulWidget {
  final Function(int page)? onPageChange;
  const PopularMoviesPaginationRow({super.key, this.onPageChange});

  @override
  State<PopularMoviesPaginationRow> createState() => _PopularMoviesPaginationRowState();
}

class _PopularMoviesPaginationRowState extends State<PopularMoviesPaginationRow> {
  @override
  Widget build(BuildContext context) {
    return NumberPaginator(
      numberPages: context.read<MovieCubit>().totalPages,
      initialPage: context.read<MovieCubit>().currentPage - 1,
      config: NumberPaginatorUIConfig(
        buttonSelectedBackgroundColor: AppColors.primary,
        buttonUnselectedForegroundColor: Theme.of(context).textTheme.bodyMedium?.color,
      ),
      onPageChange: (int index) {
        int newPage = index + 1;
        if (context.read<MovieCubit>().state is! MovieLoading && newPage != context.read<MovieCubit>().currentPage) {
          context.read<MovieCubit>().currentPage = newPage;
          context.read<MovieCubit>().fetchMovies();
          widget.onPageChange?.call(newPage);
          setState(() {});
        }
      },
    );
  }
}
