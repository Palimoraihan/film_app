import 'package:film_app/domain/entities/movie.dart';
import 'package:film_app/presentations/widget/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieList(BuildContext context,
        {required String title,
        void Function(Movie movie)? onTap,
        required AsyncValue<List<Movie>> movies}) =>
    [
      Padding(
        padding: const EdgeInsets.only(
          left: 24,
          bottom: 15,
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 228,
        child: movies.when(
          data: (data) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data
                  .map((movie) => Padding(
                    padding:  EdgeInsets.only(left: movie == data.first?24:10, right: movie==data.last?24:0),
                    child: NetworkImageCard(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                          boxFit: BoxFit.contain,
                          onTap: () => onTap?.call(movie),
                        ),
                  ))
                  .toList(),
            ),
          ),
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      )
    ];
