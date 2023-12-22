import 'package:dio/dio.dart';
import 'package:film_app/data/repository/movie_repository.dart';
import 'package:film_app/domain/entities/actor.dart';
import 'package:film_app/domain/entities/movie.dart';
import 'package:film_app/domain/entities/movie_detail.dart';
import 'package:film_app/domain/entities/result.dart';

class TmdbMovieRepository implements MovieRepository {
  final Dio? _dio;
  final String _accesToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYzdmN2IzNmYyYjc4ZWEzZjVhN2RjNTFlM2UyZDRjYyIsInN1YiI6IjY1NDYzNDk2OWNjNjdiMDEzYTMwZjEzOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-YKq0_KNYsFrCmA3_OjiMdeNyluzEG8kyh9X4uRBTu8';
  late final Options _options = Options(headers: {
    'Authorization': 'Bearer $_accesToken',
    'accept': 'application/json'
  });
  TmdbMovieRepository({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$id?language=en-US',
          options: _options);
      return Result.success(MovieDetail.fromJSON(response.data));
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async =>
      _getMovies(_MovieCategory.NOWPLAYING.toString(), page: page);

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) async =>
      _getMovies(_MovieCategory.UPCOMING.toString(), page: page);

  @override
  Future<Result<List<Actor>>> getactors({required int id}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$id/credits?language=en-US',
          options: _options);
      final result = List<Map<String, dynamic>>.from(response.data['cast']);

      return Result.success(result.map((e) => Actor.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  Future<Result<List<Movie>>> _getMovies(String category,
      {int page = 1}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$category?language=en-US&page=$page',
          options: _options);
      final resault = List<Map<String, dynamic>>.from(response.data['results']);
      return Result.success(resault.map((e) => Movie.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

enum _MovieCategory {
  NOWPLAYING('now_playing'),
  UPCOMING('upcoming');

  final String _instring;

  const _MovieCategory(String instring) : _instring = instring;

  @override
  String toString() => _instring;
}
