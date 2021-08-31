import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  static Page page(User user) {
    return MaterialPage<void>(
      child: ProfilePage(user: user),
    );
  }

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.email),
            Text(user.biography),
          ],
        ),
      ),
    );
  }
}
