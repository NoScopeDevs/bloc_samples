import 'package:flutter_test/flutter_test.dart';
import 'package:profile_accounts/profile/profile.dart';

class FakeUser extends Fake implements User {}

void main() {
  group('ProfileEvent', () {
    final user = FakeUser();
    group('ProfileAccountAdded', () {
      test('supports value comparison', () {
        expect(
          ProfileAccountAdded(user),
          ProfileAccountAdded(user),
        );
      });
    });

    group('ProfileCurrentAccountChanged', () {
      test('supports value comparison', () {
        expect(
          ProfileCurrentAccountChanged(user),
          ProfileCurrentAccountChanged(user),
        );
      });
    });
  });
}
