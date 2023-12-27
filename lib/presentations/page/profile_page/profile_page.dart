import 'package:film_app/presentations/misc/method.dart';
import 'package:film_app/presentations/page/profile_page/method/profile_item.dart';
import 'package:film_app/presentations/page/profile_page/method/user_info.dart';
import 'package:film_app/presentations/provider/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              verticalSpace(20),
              ...userInfo(ref, context),
              verticalSpace(20),
              const Divider(),
              profileItem('Update Profile'),
              profileItem('My Walet'),
              profileItem('Change Password'),
              profileItem('Change Language'),
              verticalSpace(20),
              const Divider(),
              profileItem('Contact As'),
              profileItem('Privacy Policy'),
              profileItem('Terms and Conditions'),
              verticalSpace(60),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(userDataProvider.notifier).logout();
                  },
                  child: Text('Logout'),
                ),
              ),
              verticalSpace(20),
              Text('Version 0.0.1', style: Theme.of(context).textTheme.bodyMedium,),
              verticalSpace(20)
            ],
          ),
        ),
      ],
    );
  }
}
