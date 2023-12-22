enum MovieListCategories { NOWPLAYING, UPCOMING }

class GetMovieListParam {
  final int page;
  final MovieListCategories categories;

  GetMovieListParam({this.page = 1 , required this.categories});
}
