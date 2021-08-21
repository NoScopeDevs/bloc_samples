import 'package:preferences/preferences.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakePreferencesRepository extends Fake implements PreferencesRepository {}

void main() {
  test('instance the PreferencesRepository', () async {
    final fake = FakePreferencesRepository();
    expect(fake, isA<PreferencesRepository>());
  });
}
