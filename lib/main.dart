import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/navigation/routes.dart';
import 'core/theme/app_theme.dart';
import 'features/movies/presentation/cubit/movie/movie_cubit.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<MovieCubit>()..fetchMovies(page: 1)),
      ],
      child: MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        navigatorKey: sl<GlobalKey<NavigatorState>>(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: Routes.moviesList,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
