import 'package:film_app/presentations/misc/method.dart';
import 'package:film_app/presentations/provider/movie/upcoming_provider.dart';
import 'package:film_app/presentations/provider/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/movie/now_playing_provider.dart';
import 'method/movie_list.dart';
import 'method/promotion_list.dart';
import 'method/search_bar_widget.dart';
import 'method/user_info_main.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promosionFileImageName = const [
    'popcorn.jpg',
    'buy1get1.jpg'
  ];
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInfoMain(ref, context),
            verticalSpace(40),
            searchBarWidget(context),
            verticalSpace(24),
            ...movieList(
              context,
              title: 'Now Playing',
              movies: ref.watch(nowPlayingProvider),
              onTap: (movie) {
                ref.read(routerProvider).pushNamed('detail', extra: movie);
              },
            ),
            verticalSpace(24),
            ...promotionList(promosionFileImageName, context),
            verticalSpace(24),
            ...movieList(
              context,
              title: 'Upcoming',
              movies: ref.watch(upcomingProvider),
              onTap: (movie) {},
            ),
            verticalSpace(80)
          ],
        )
      ],
    );
  }
}
