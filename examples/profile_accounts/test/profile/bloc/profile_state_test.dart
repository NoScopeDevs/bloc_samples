// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_accounts/profile/profile.dart';

void main() {
  group('ProfileState', () {
    group('ProfileInitial', () {
      test('supports value comparison', () {
        expect(ProfileInitial(), ProfileInitial());
      });
    });
  });
}
