import 'package:film_app/domain/entities/user.dart';
import 'package:film_app/presentations/extensions/build_extensions.dart';
import 'package:film_app/presentations/misc/method.dart';
import 'package:film_app/presentations/page/movie_page/movie_page.dart';
import 'package:film_app/presentations/page/profile_page/profile_page.dart';
import 'package:film_app/presentations/provider/router/router_provider.dart';
import 'package:film_app/presentations/provider/user_data/user_data_provider.dart';
import 'package:film_app/presentations/widget/bottom_navbar.dart';
import 'package:film_app/presentations/widget/bottom_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    print('in run');
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).goNamed('login');
        } else if (next is AsyncError) {
          context.showSnacBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) => setState(() {
              selectedPage = value;
            }),
            children: [
              Center(
                child: MoviePage()
              ),
              Center(
                child: Text('Ticket Page'),
              ),
              Center(child: ProfilePage())
            ],
          ),
          BottomNavBar(
              items: [
                BottomNavbarItem(
                    indext: 0,
                    isSelected: selectedPage == 0,
                    title: 'Home',
                    image: 'assets/image/movie.png',
                    selectedImage: 'assets/image/movie-selected.png'),
                BottomNavbarItem(
                    indext: 1,
                    isSelected: selectedPage == 1,
                    title: 'Ticket',
                    image: 'assets/image/ticket.png',
                    selectedImage: 'assets/image/ticket-selected.png'),
                BottomNavbarItem(
                    indext: 2,
                    isSelected: selectedPage == 2,
                    title: 'Profile',
                    image: 'assets/image/profile.png',
                    selectedImage: 'assets/image/profile-selected.png')
              ],
              onTap: (index) {
                selectedPage = index;
                pageController.animateToPage(selectedPage,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut);
              },
              selectedIndex: 0)
        ],
      ),
    );
  }
}
