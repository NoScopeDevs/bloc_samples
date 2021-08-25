import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_accounts/profile/profile.dart';
import 'package:profile_core/profile_core.dart';

import '../../helpers/helpers.dart';

void main() {
  final mockUser = User(name: 'Marcos', email: 'marcos@noscope.dev');
  final anotherMockUser = User(name: 'Elian', email: 'elian@noscope.dev');
  final mockUsers = [mockUser, anotherMockUser];

  setUpAll(() {
    registerFallbackValue<ProfileState>(FakeProfileState());
    registerFallbackValue<ProfileEvent>(FakeProfileEvent());
  });

  group('ProfileDrawer', () {
    testWidgets('renders ProfileHeader and ProfileAccountList', (tester) async {
      final profileBloc = MockProfileBloc();
      when(() => profileBloc.state).thenReturn(const ProfileInitial());

      await tester.pumpApp(
        const ProfileDrawer(),
        profileBloc: profileBloc,
      );

      expect(find.byType(ProfileHeader), findsOneWidget);
      expect(find.byType(ProfileAccountList), findsOneWidget);
    });
  });

  group('ProfileHeader', () {
    testWidgets(
      'renders Text with no-user when state is not ProfileLoaded',
      (tester) async {
        final profileBloc = MockProfileBloc();
        when(() => profileBloc.state).thenReturn(const ProfileInitial());

        await tester.pumpApp(
          const ProfileHeader(),
          profileBloc: profileBloc,
        );

        expect(find.text('no-user'), findsOneWidget);
      },
    );

    testWidgets(
      'renders Text with currentUser email when state is ProfileLoaded',
      (tester) async {
        final profileBloc = MockProfileBloc();
        when(() => profileBloc.state).thenReturn(
          ProfileLoaded(current: mockUser, accounts: mockUsers),
        );

        await tester.pumpApp(
          const ProfileHeader(),
          profileBloc: profileBloc,
        );

        expect(find.text(mockUser.email), findsOneWidget);
      },
    );
  });

  group('ProfileAccountList', () {
    testWidgets(
      'renders SizedBox.shrink when state is not ProfileLoaded',
      (tester) async {
        final profileBloc = MockProfileBloc();
        when(() => profileBloc.state).thenReturn(const ProfileInitial());

        await tester.pumpApp(
          const ProfileAccountList(),
          profileBloc: profileBloc,
        );

        expect(find.byType(SizedBox), findsOneWidget);
      },
    );

    testWidgets(
      'renders Column with the right amount of '
      'account tiles when state is ProfileLoaded',
      (tester) async {
        final profileBloc = MockProfileBloc();
        when(() => profileBloc.state).thenReturn(
          ProfileLoaded(current: mockUser, accounts: mockUsers),
        );

        await tester.pumpApp(
          const Material(
            child: ProfileAccountList(),
          ),
          profileBloc: profileBloc,
        );

        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(ListTile), findsNWidgets(2));
      },
    );

    testWidgets(
      'adds ProfileCurrentAccountChanged with last user '
      'on accounts when pressing last ListTile',
      (tester) async {
        final profileBloc = MockProfileBloc();
        when(() => profileBloc.state).thenReturn(
          ProfileLoaded(current: mockUser, accounts: mockUsers),
        );

        await tester.pumpApp(
          const Material(
            child: ProfileAccountList(),
          ),
          profileBloc: profileBloc,
        );
        await tester.tap(find.byType(ListTile).last);

        verify(
          () => profileBloc.add(ProfileCurrentAccountChanged(anotherMockUser)),
        ).called(1);
      },
    );
  });
}
