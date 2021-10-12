import 'package:profile_core/profile_core.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('supports value comparisons', () {
      expect(User(email: '', name: '') == User(email: '', name: ''), false);
    });
  });
}
