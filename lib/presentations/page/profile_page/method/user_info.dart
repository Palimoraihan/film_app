import 'package:film_app/presentations/misc/method.dart';
import 'package:film_app/presentations/provider/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> userInfo(WidgetRef ref, BuildContext context) => [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 1),
          image: DecorationImage(fit: BoxFit.cover,image: ref.watch(userDataProvider).valueOrNull?.photoUrl != null?NetworkImage(ref.watch(userDataProvider).valueOrNull!.photoUrl!)as ImageProvider:const AssetImage('assets/image/pp-placeholder.png'))
        ),
      ),
      verticalSpace(20),
      Text(ref.watch(userDataProvider).valueOrNull?.name??'',style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
      Text(
        ref.watch(userDataProvider).valueOrNull?.email ?? '',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
      )
    ];
