import 'package:flutter/material.dart';

class NoMoviesWidget extends StatelessWidget {
  const NoMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No movies found',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 32, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }
}
