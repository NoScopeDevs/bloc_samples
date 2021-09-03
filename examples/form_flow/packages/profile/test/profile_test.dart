// ignore_for_file: prefer_const_constructors

import 'package:profile/profile.dart';
import 'package:test/test.dart';

void main() {
  group('Profile', () {
    test('can be instantiated', () {
      expect(User(name: '', email: '', biography: '', pin: ''), isNotNull);
    });
  });
}
