import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../gen/assets.gen.dart';

class PopularMoviesAppBar extends StatelessWidget {
  const PopularMoviesAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    return SliverAppBar(
      expandedHeight: screenHeight * 0.3,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Popular Movies',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        background: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            bottom: screenHeight * 0.1,
          ),
          child: SvgPicture.asset(
            Assets.images.tmdb,
            color: AppColors.secondary,
            // colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.dstOver),
          ),
        ),
      ),
    );
  }
}
