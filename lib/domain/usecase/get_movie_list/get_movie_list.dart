import 'package:film_app/data/repository/movie_repository.dart';
import 'package:film_app/domain/entities/movie.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/get_movie_list/get_movie_list_param.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class GetMovieList implements UseCase<Result<List<Movie>>, GetMovieListParam> {
  final MovieRepository _movieRepository;

  GetMovieList({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;
  @override
  Future<Result<List<Movie>>> call(GetMovieListParam param) async {
    var movieResult = switch (param.categories) {
      MovieListCategories.NOWPLAYING =>
        await _movieRepository.getNowPlaying(page: param.page),
      MovieListCategories.UPCOMING =>
        await _movieRepository.getUpcoming(page: param.page),
    };
    return switch (movieResult) {
      Success(value: final movies)=>Result.success(movies),
      Failed(:final message)=> Result.failed(message)
    };
  }
}
