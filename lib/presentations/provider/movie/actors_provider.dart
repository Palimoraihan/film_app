import 'package:film_app/domain/entities/actor.dart';
import 'package:film_app/domain/entities/result.dart';
import 'package:film_app/domain/usecase/get_actors/get_actors.dart';
import 'package:film_app/domain/usecase/get_actors/get_actors_params.dart';
import 'package:film_app/presentations/provider/usecase/get_actors_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_provider.g.dart';

@riverpod
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActors getActors = ref.read(getActorsProvider);

  var actorResault = await getActors(GetActorsParam(movieId: movieId));
  return switch (actorResault) {
    Success(value: final actors) => actors,
    Failed(message: _) => const []
  };
}
