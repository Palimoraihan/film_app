import 'package:film_app/domain/entities/movie.dart';
import 'package:film_app/presentations/misc/method.dart';
import 'package:film_app/presentations/provider/movie/actors_provider.dart';
import 'package:film_app/presentations/widget/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> castAndCrew(BuildContext context,
        {required Movie movie, required WidgetRef ref}) =>
    [
      Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Text(
          'Cast & Crew',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      verticalSpace(10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            horizontalSpace(24),
            ...(ref.watch(actorsProvider(movieId: movie.id)).whenOrNull(
                      data: (actorsData) => actorsData
                          .where((element) => element.profilePath != null)
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  NetworkImageCard(
                                    width: 100,
                                    height: 152,
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w185/${e.profilePath}',
                                    boxFit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text('${e.name}', maxLines: 2,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,))
                                ],
                              ),
                            ),
                          ),
                    ) ??
                []),
                horizontalSpace(14)
          ],
        ),
      ),
    ];
