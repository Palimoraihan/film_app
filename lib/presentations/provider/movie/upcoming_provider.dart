import 'package:film_app/domain/entities/movie.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/get_movie_list/get_movie_list.dart';
import 'package:film_app/domain/usecase/get_movie_list/get_movie_list_param.dart';
import 'package:film_app/presentations/provider/usecase/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upcoming_provider.g.dart';

@Riverpod(keepAlive: true)
class Upcoming extends _$Upcoming {
  @override
  FutureOr<List<Movie>> build() => const [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();
    GetMovieList getMovieList = ref.read(getMovieListProvider);

    var resault = await getMovieList(GetMovieListParam(
        categories: MovieListCategories.UPCOMING, page: page));

    switch (resault) {
      case Success(value: final movies):
        state = AsyncData(movies);
      case Failed(message: _):
        state = AsyncData([]);
    }
  }
}
