import 'package:film_app/domain/entities/movie.dart';
import 'package:film_app/presentations/misc/constant.dart';
import 'package:flutter/material.dart';

List<Widget> backGround(Movie movie) => [
      Image.network(
        'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            backgroundColor.withOpacity(1),
            backgroundColor.withOpacity(.7),
          ],
          begin: Alignment(0, 0.3),
          end: Alignment.topCenter
        )),
      )
    ];
