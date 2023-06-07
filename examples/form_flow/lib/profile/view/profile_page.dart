import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/app/app.dart';
import 'package:profile/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.user,
    super.key,
  });

  static Page<void> page(User user) {
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
        actions: [
          IconButton(
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.email,
                style: const TextStyle(fontSize: 10),
              ),
              Text(user.biography),
            ],
          ),
        ),
      ),
    );
  }
}
