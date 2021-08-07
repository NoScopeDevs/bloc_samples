import 'package:flutter_test/flutter_test.dart';
import 'package:profile_accounts/profile/profile.dart';

void main() {
  group('ProfileBloc', () {
    test('emits initial state when instantiated', () {
      expect(ProfileBloc().state, const ProfileInitial());
    });
  });
}
