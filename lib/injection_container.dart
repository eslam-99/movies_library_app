import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'core/api/api_service.dart';
import 'core/network/network_info.dart';
import 'features/movies/data/data_sources/local/movie_local_datasource.dart';
import 'features/movies/data/models/movie_model.dart';
import 'features/movies/data/repositories/movie_repository_impl.dart';
import 'features/movies/domain/entities/movie.dart';
import 'features/movies/domain/repositories/movie_repository.dart';
import 'features/movies/domain/usecases/get_movie_details.dart';
import 'features/movies/data/data_sources/remote/movie_remote_datasource.dart';
import 'features/movies/domain/usecases/get_popular_movies.dart';
import 'features/movies/presentation/cubit/movie/movie_cubit.dart';
import 'features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  // Hive.initFlutter();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieModelAdapter());
  final movieBox = await Hive.openBox<MovieModel>('cached_movies_box');

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);

  // External Dependencies
  sl.registerLazySingleton<Dio>(() => Dio());

  // Core Services
  sl.registerLazySingleton<ApiService>(() => ApiService(sl()));

  // Data Sources
  sl.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl(movieBox));
  sl.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(sl()));

  // Repositories
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl(), sl(), sl()));

  // Use Cases
  sl.registerLazySingleton<GetPopularMovies>(() => GetPopularMovies(sl()));
  sl.registerLazySingleton<GetMovieDetails>(() => GetMovieDetails(sl()));

  // Cubits
  sl.registerFactory<MovieCubit>(() => MovieCubit(sl()));
  sl.registerFactory<MovieDetailsCubit>(() => MovieDetailsCubit(sl()));
}
