import 'package:film_app/data/repository/movie_repository.dart';
import 'package:film_app/domain/entities/movie_detail.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/get_movie_detail/get_movie_detail_params.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class GetMovieDetail
    implements UseCase<Result<MovieDetail>, GetMovieDatailParams> {
  final MovieRepository _movieRepository;

  GetMovieDetail({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<MovieDetail>> call(GetMovieDatailParams param) async {
    var movieDetailResult =
        await _movieRepository.getDetail(id: param.movie.id);

    return switch (movieDetailResult) {
      Success(value: final movieDetail) => Result.success(movieDetail),
      Failed(:final message) => Result.failed(message)
    };
  }
}
