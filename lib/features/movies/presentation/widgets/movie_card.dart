import 'package:flutter/material.dart';
import 'package:movies_library_app/core/navigation/app_nav.dart';
import 'package:movies_library_app/core/widgets/custom_network_image.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/api/api_constants.dart';
import '../../domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(15.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          AppNav.toNamed(context, Routes.movieDetails, extra: movie);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 4,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Hero(
                      tag: movie.title,
                      child: CNetworkImage(
                        url: movie.posterPath,
                        borderRadius: 7.0,
                        borderWidth: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '⭐ ${movie.voteAverage.toString()}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            movie.releaseDate,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
