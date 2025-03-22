import 'package:flutter/material.dart';
import 'package:movies_library_app/core/widgets/custom_network_image.dart';

class MovieDetailsAppBar extends StatelessWidget {
  final String title;
  final String poster;

  const MovieDetailsAppBar({super.key, required this.title, required this.poster});

  @override
  Widget build(BuildContext context) {
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    return SliverAppBar(
      expandedHeight: screenHeight * 0.6,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            maxLines: 2,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
          ),
        ),
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(tag: title, child: CNetworkImage(url: poster)),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent, Colors.transparent, Colors.black87],
                  // colors: [Colors.black38, Colors.black38, Colors.black54],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
