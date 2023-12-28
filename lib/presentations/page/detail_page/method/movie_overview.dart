import 'package:film_app/domain/entities/movie_detail.dart';
import 'package:film_app/presentations/misc/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieOverview(
        AsyncValue<MovieDetail?> asyncMovieDetail, BuildContext context) =>
    [
      Text(
        'Overview',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      verticalSpace(10),
      asyncMovieDetail.when(data: (movieDetail) => Text(movieDetail?.overview??'', style: Theme.of(context).textTheme.bodyMedium,) , error: (error, stackTrace) => const Text('Filed load movie overview please try again'), loading: () => const CircularProgressIndicator(),)
    ];
