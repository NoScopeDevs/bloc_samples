import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_accounts/profile/profile.dart';
import 'package:profile_core/profile_core.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<ProfileState>(FakeProfileState());
    registerFallbackValue<ProfileEvent>(FakeProfileEvent());
  });

  group('ProfilePage', () {
    testWidgets('renders a ProfileView', (tester) async {
      await tester.pumpApp(const ProfilePage());
      expect(find.byType(ProfileView), findsOneWidget);
    });
  });

  group('ProfileView', () {
    final mockUser = User(name: 'Marcos', email: 'marcos@noscope.dev');

    testWidgets(
      'renders a Text with no-user when state is ProfileInitial',
      (tester) async {
        final profileBloc = MockProfileBloc();
        when(() => profileBloc.state).thenReturn(const ProfileInitial());

        await tester.pumpApp(
          const ProfileView(),
          profileBloc: profileBloc,
        );
        expect(find.text('no-user'), findsOneWidget);
      },
    );

    testWidgets(
      'renders a Text with currentUser when state is ProfileLoaded',
      (tester) async {
        final profileBloc = MockProfileBloc();
        when(() => profileBloc.state).thenReturn(
          ProfileLoaded(current: mockUser, accounts: [mockUser]),
        );

        await tester.pumpApp(
          const ProfileView(),
          profileBloc: profileBloc,
        );
        expect(find.text(mockUser.email), findsOneWidget);
      },
    );

    testWidgets(
      'renders a Text with error when state '
      'is not [ProfileInitial, ProfileLoaded]',
      (tester) async {
        final profileBloc = MockProfileBloc();
        when(() => profileBloc.state).thenReturn(const ProfileError());

        await tester.pumpApp(
          const ProfileView(),
          profileBloc: profileBloc,
        );
        expect(find.text('error'), findsOneWidget);
      },
    );
  });

  group('ProfileAddAccountButton', () {
    testWidgets(
      'renders a ProfileCard in a BottomSheet '
      'when FloatingActionButton is pressed',
      (tester) async {
        await tester.pumpApp(
          const Scaffold(
            body: ProfileAddAccountButton(),
          ),
        );
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(ProfileCard), findsOneWidget);
      },
    );
  });
}
