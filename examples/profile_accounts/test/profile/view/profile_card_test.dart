import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_accounts/profile/profile.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<ProfileState>(FakeProfileState());
    registerFallbackValue<ProfileEvent>(FakeProfileEvent());
  });

  group('ProfileCard', () {
    testWidgets('renders a ProfileForm', (tester) async {
      await tester.pumpApp(const ProfileCard());
      expect(find.byType(ProfileForm), findsOneWidget);
    });
  });
}
