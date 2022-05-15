import 'package:flutter/material.dart';
import 'package:profile_accounts/profile/profile.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profile Accounts',
      home: ProfilePage(),
    );
  }
}
