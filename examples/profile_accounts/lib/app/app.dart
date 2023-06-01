import 'package:flutter/material.dart';
import 'package:profile_accounts/profile/profile.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Profile Accounts',
      home: const ProfilePage(),
    );
  }
}
