import 'package:film_app/domain/entities/movie_detail.dart';
import 'package:film_app/presentations/misc/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieShortInfo(
        {required AsyncValue<MovieDetail?> asyncValueDetail,
        required BuildContext context}) =>
    [
      Row(
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/image/duration.png'),
          ),
          horizontalSpace(5),
          SizedBox(
            width: 95,
            child: Text(
              '${asyncValueDetail.when(
                data: (movieDetail) =>
                    movieDetail != null ? movieDetail.runtime : '-',
                error: (error, stackTrace) => '-',
                loading: () => '-',
              )} Minute',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/image/genre.png'),
          ),
          horizontalSpace(5),
          SizedBox(
            width:
                MediaQuery.of(context).size.width - 48 - 95 - 14 - 14 - 5 - 5,
            child: asyncValueDetail.when(
              data: (movieDetail) {
                String genre = movieDetail?.genres.join(', ') ?? '-';
                return Text(
                  genre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
              error: (error, stackTrace) => Text(
                '-',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              loading: () => Text(
                '-',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          )
        ],
      ),
      verticalSpace(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 18,width: 18,child: Image.asset('assets/image/star.png'),),
          horizontalSpace(10),
          Text((asyncValueDetail.valueOrNull?.voteAverage??0).toStringAsFixed(1))
        ],
      )
    ];
