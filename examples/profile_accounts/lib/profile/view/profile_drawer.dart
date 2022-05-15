import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_accounts/profile/profile.dart';
import 'package:profile_core/profile_core.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: const ProfileHeader(),
            ),
            const ProfileAccountList(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const textHeaderStyle = TextStyle(color: Colors.black);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (_, state) {
        if (state is ProfileLoaded) {
          return Text(state.current.email, style: textHeaderStyle);
        }

        return const Text('no-user', style: textHeaderStyle);
      },
    );
  }
}

class ProfileAccountList extends StatelessWidget {
  const ProfileAccountList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileBloc, ProfileState, List<User>>(
      selector: (state) {
        if (state is ProfileLoaded) return state.accounts;
        return [];
      },
      builder: (_, accounts) {
        if (accounts.isNotEmpty) {
          return Column(
            children: [
              for (final account in accounts)
                ListTile(
                  title: Text(account.name),
                  subtitle: Text(account.email),
                  onTap: () {
                    final event = ProfileCurrentAccountChanged(account);
                    context.read<ProfileBloc>().add(event);
                  },
                )
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
