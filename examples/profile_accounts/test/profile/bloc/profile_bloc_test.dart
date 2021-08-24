import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_accounts/profile/profile.dart';
import 'package:profile_core/profile_core.dart';

class FakeUser extends Fake implements User {}

class FakeProfileState extends Fake implements ProfileState {}

void main() {
  group('ProfileBloc', () {
    // To differentiate when changing `currentUser`
    final user = FakeUser();
    final currentUser = FakeUser();

    test('emits initial state when instantiated', () {
      expect(ProfileBloc().state, const ProfileInitial());
    });

    group('ProfileAccountAdded', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoaded] when ProfileAccountAdded is added.',
        build: () => ProfileBloc(),
        act: (bloc) => bloc.add(ProfileAccountAdded(user)),
        expect: () => <ProfileState>[
          ProfileLoaded(current: user, accounts: [user]),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoaded] when ProfileAccountAdded is added '
        'and state is ProfileLoaded.',
        build: () => ProfileBloc(),
        seed: () => ProfileLoaded(current: user, accounts: [user]),
        act: (bloc) => bloc.add(ProfileAccountAdded(currentUser)),
        expect: () => <ProfileState>[
          ProfileLoaded(current: user, accounts: [user, currentUser]),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileError] when ProfileAccountAdded '
        'and state is FakeProfileState.',
        build: () => ProfileBloc(),
        seed: () => FakeProfileState(),
        act: (bloc) => bloc.add(ProfileAccountAdded(user)),
        expect: () => const <ProfileState>[ProfileError()],
      );
    });

    group('ProfileCurrentAccountChanged', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoaded] when ProfileCurrentAccountChanged is added.',
        build: () => ProfileBloc(),
        seed: () => ProfileLoaded(current: user, accounts: [user, currentUser]),
        act: (bloc) => bloc.add(ProfileCurrentAccountChanged(currentUser)),
        expect: () => <ProfileState>[
          ProfileLoaded(current: currentUser, accounts: [user, currentUser]),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoaded] when ProfileCurrentAccountChanged is added '
        'and state is FakeProfileState.',
        build: () => ProfileBloc(),
        seed: () => FakeProfileState(),
        act: (bloc) => bloc.add(ProfileCurrentAccountChanged(currentUser)),
        expect: () => const <ProfileState>[ProfileError()],
      );
    });
  });
}
