import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_accounts/profile/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const ProfileDrawer(),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (_, state) {
          if (state is ProfileInitial) {
            return const Center(child: Text('no-user'));
          } else if (state is ProfileLoaded) {
            return Center(child: Text(state.current.email));
          } else {
            return const Center(child: Text('error'));
          }
        },
      ),
      floatingActionButton: const ProfileAddAccountButton(),
    );
  }
}

class ProfileAddAccountButton extends StatelessWidget {
  const ProfileAddAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('New user'),
      onPressed: () {
        Scaffold.of(context).showBottomSheet<Widget>(
          (_) => const ProfileCard(),
        );
      },
    );
  }
}
