import 'package:film_app/domain/entities/actor.dart';
import 'package:film_app/domain/entities/movie.dart';
import 'package:film_app/domain/entities/movie_detail.dart';
import 'package:film_app/domain/entities/result.dart';

abstract class MovieRepository {
  Future<Result<List<Movie>>> getNowPlaying({int page = 1});
  Future<Result<List<Movie>>> getUpcoming({int page = 1});
  Future<Result<MovieDetail>> getDetail({required int id});
  Future<Result<List<Actor>>> getactors({required int id});
}
