import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_accounts/profile/profile.dart';

import '../../helpers/helpers.dart';

class FakeProfileAcountAdded extends Fake implements ProfileAccountAdded {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeProfileAcountAdded());
  });

  group('ProfileForm', () {
    const mockName = 'Marcos';
    const mockEmail = 'marcos@noscope.dev';

    const profileNameInputKey = Key('profileForm_nameInput_textField');
    const profileEmailInputKey = Key('profileForm_emailInput_textField');
    const profileSaveButtonKey = Key('profileForm_save_textButton');

    testWidgets(
      'adds ProfileAccountAdded when filling up form and TextButton is pressed',
      (tester) async {
        final profileBloc = MockProfileBloc();

        await tester.pumpApp(
          const Material(
            child: ProfileForm(),
          ),
          profileBloc: profileBloc,
        );
        await tester.enterText(find.byKey(profileNameInputKey), mockName);
        await tester.enterText(find.byKey(profileEmailInputKey), mockEmail);
        await tester.ensureVisible(find.byKey(profileSaveButtonKey));
        await tester.tap(find.byKey(profileSaveButtonKey));

        verify(
          () => profileBloc.add(
            any<ProfileAccountAdded>(
              that: isA<ProfileAccountAdded>()
                  .having(
                    (e) => e.account.name,
                    'name',
                    mockName,
                  )
                  .having(
                    (e) => e.account.email,
                    'email',
                    mockEmail,
                  ),
            ),
          ),
        ).called(1);
      },
    );
  });
}
