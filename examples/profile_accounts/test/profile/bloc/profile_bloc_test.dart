import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_accounts/profile/profile.dart';
import 'package:profile_core/profile_core.dart';

class FakeUser extends Fake implements User {}

void main() {
  group('ProfileBloc', () {
    // To differentiate when changing `currentUser`
    final currentUser = User(
      name: 'Marcos',
      email: 'marcos@noscope.dev',
    );
    final user = User(
      name: 'Elian',
      email: 'elian@noscope.dev',
    );

    test('emits initial state when instantiated', () {
      expect(ProfileBloc().state, const ProfileInitial());
    });

    group('ProfileAccountAdded', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoaded] when ProfileAccountAdded is added.',
        build: ProfileBloc.new,
        act: (bloc) => bloc.add(ProfileAccountAdded(user)),
        expect: () => <ProfileState>[
          ProfileLoaded(current: user, accounts: [user]),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoaded] when ProfileAccountAdded is added '
        'and state is ProfileLoaded.',
        build: ProfileBloc.new,
        seed: () => ProfileLoaded(current: user, accounts: [user]),
        act: (bloc) => bloc.add(ProfileAccountAdded(currentUser)),
        expect: () => <ProfileState>[
          ProfileLoaded(current: user, accounts: [user, currentUser]),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoaded] when ProfileAccountAdded '
        'and state is ProfileError.',
        build: ProfileBloc.new,
        seed: ProfileError.new,
        act: (bloc) => bloc.add(ProfileAccountAdded(user)),
        expect: () => <ProfileState>[
          ProfileLoaded(
            current: user,
            accounts: [user],
          ),
        ],
      );
    });

    group('ProfileCurrentAccountChanged', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoaded] when ProfileCurrentAccountChanged is added.',
        build: ProfileBloc.new,
        seed: () => ProfileLoaded(current: user, accounts: [user, currentUser]),
        act: (bloc) => bloc.add(ProfileCurrentAccountChanged(currentUser)),
        expect: () => <ProfileState>[
          ProfileLoaded(current: currentUser, accounts: [user, currentUser]),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoaded] when ProfileCurrentAccountChanged is added '
        'and state is FakeProfileState.',
        build: ProfileBloc.new,
        act: (bloc) => bloc.add(ProfileCurrentAccountChanged(currentUser)),
        expect: () => const <ProfileState>[ProfileError()],
      );
    });
  });
}
