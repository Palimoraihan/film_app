import 'package:film_app/presentations/extensions/int_extension.dart';
import 'package:film_app/presentations/misc/method.dart';
import 'package:film_app/presentations/provider/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget userInfoMain(WidgetRef ref, BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ref.watch(userDataProvider).valueOrNull?.photoUrl !=
                            null
                        ? NetworkImage(ref
                            .watch(userDataProvider)
                            .valueOrNull!
                            .photoUrl!) as ImageProvider
                        : const AssetImage('assets/image/pp-placeholder.png'))),
          ),
          horizontalSpace(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${getGreeting()} ${ref.watch(userDataProvider).when(
                    data: (user) => user?.name.split(' ').first ?? '',
                    error: (error, stackTrace) => '',
                    loading: () => 'Loading...',
                  )}!', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
                  Text(
                "Let's book your favorite movie !",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              verticalSpace(5),
              GestureDetector(
                onTap: () {
                  
                },
                child: Row(children: [
                  SizedBox(width: 18,height: 18,child: Image.asset('assets/image/wallet.png'),),
                  horizontalSpace(10),
                  Text(ref.watch(userDataProvider).when(data: (user) => (user?.balance
                  ??0).toIDRCurrentCyFormat(), error: (error, stackTrace) => 'IDR 0', loading: () => 'Loading...',), style: const TextStyle(fontWeight: FontWeight.bold),)
                ],),
              )
            ],
          ),
          
        ],
      ),
    );

String getGreeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}
