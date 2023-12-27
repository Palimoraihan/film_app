import 'package:film_app/domain/entities/movie.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/get_movie_detail/get_movie_detail.dart';
import 'package:film_app/domain/usecase/get_movie_detail/get_movie_detail_params.dart';
import 'package:film_app/presentations/provider/usecase/get_movie_detail_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/movie_detail.dart';

part 'movie_detail_provider.g.dart';
@riverpod
Future<MovieDetail?> movieDetail(MovieDetailRef ref,
    {required Movie movie}) async {
  GetMovieDetail getMovieDetail = ref.read(getMovieDetailProvider);
  var movieDateilResult =
      await getMovieDetail(GetMovieDatailParams(movie: movie));
  return switch (movieDateilResult) {
    Success(value: final movieDetail)=> movieDetail, Failed(message:_)=> null
  };
}
