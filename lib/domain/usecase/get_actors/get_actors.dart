import 'package:film_app/data/repository/movie_repository.dart';
import 'package:film_app/domain/entities/actor.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/get_actors/get_actors_params.dart';
import 'package:film_app/domain/usecase/usecase.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorsParam> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Actor>>> call(GetActorsParam param) async {
    var actorListResult = await _movieRepository.getactors(id: param.movieId);
    return switch (actorListResult) {
      Success(value: final actorList)=> Result.success(actorList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
