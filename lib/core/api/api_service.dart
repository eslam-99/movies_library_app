import 'package:dio/dio.dart';

import 'api_constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer ${ApiConstants.apiKey}',
      'Content-Type': 'application/json',
    };
  }

  Future<Response> getMovies({required int page}) async {
    try {
      return await _dio.get('/movie/popular', queryParameters: {'page': page});
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMovieDetails(int movieId) async {
    try {
      return await _dio.get('/movie/$movieId');
    } catch (e) {
      rethrow;
    }
  }
}
