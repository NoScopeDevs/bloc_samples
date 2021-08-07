import 'package:profile_core/profile_core.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('can be instantiated', () {
      expect(User(email: '', name: ''), isNotNull);
    });
  });
}
