import 'package:film_app/presentations/misc/constant.dart';
import 'package:film_app/presentations/misc/method.dart';
import 'package:film_app/presentations/page/detail_page/method/background.dart';
import 'package:film_app/presentations/page/detail_page/method/cast_and_crew.dart';
import 'package:film_app/presentations/page/detail_page/method/movie_overview.dart';
import 'package:film_app/presentations/provider/movie/movie_detail_provider.dart';
import 'package:film_app/presentations/provider/router/router_provider.dart';
import 'package:film_app/presentations/widget/back_navigation.dart';
import 'package:film_app/presentations/widget/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import 'method/movie_short_info.dart';

class DetailPage extends ConsumerWidget {
  final Movie movie;
  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncMovieDetail = ref.watch(MovieDetailProvider(movie: movie));
    return Scaffold(
      body: Stack(
        children: [
          ...backGround(movie),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackNavigationBar(
                      title: movie.title,
                      onTap: () => ref.read(routerProvider).pop(),
                    ),
                    verticalSpace(24),
                    //backdrop image
                    NetworkImageCard(
                      width: MediaQuery.of(context).size.width - 48,
                      height: (MediaQuery.of(context).size.width - 48)*0.6,
                      borderRadius: 15,
                      boxFit: BoxFit.cover,
                      imageUrl: asyncMovieDetail.valueOrNull!= null?'https://image.tmdb.org/t/p/w500/${asyncMovieDetail.value!.backdropPath?? movie.posterPath}':null,
                    ),
                    verticalSpace(24),
                    ...movieShortInfo(asyncValueDetail: asyncMovieDetail,context: context),
                    verticalSpace(20),
                    ...movieOverview(asyncMovieDetail,context),
                    verticalSpace(40),
                  ],
                ),
              ),
              ...castAndCrew(context,movie: movie, ref: ref),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        foregroundColor: backgroundColor,
                        backgroundColor: saffron,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text('Book this Movie')),
              )
            ],
          )
        ],
      ),
    );
  }
}
