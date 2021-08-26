import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preference_navigation/app/app.dart';
import 'package:preference_navigation/preferences/preferences.dart';

import '../../helpers/helpers.dart';

void main() {
  late MockSharedPreferencesRepository mockSharedPreferenceRepository;

  setUpAll(() {
    registerFallbackValue<PreferencesState>(FakePreferencesState());
    registerFallbackValue<PreferencesEvent>(FakePreferencesEvent());
  });

  group('App', () {
    setUp(() {
      mockSharedPreferenceRepository = MockSharedPreferencesRepository();
    });

    testWidgets('renders AppView with SharedPreferences instance',
        (tester) async {
      final preferencesBloc = MockPreferencesBloc();
      when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

      await tester.pumpApp(
        App(preferencesRepository: mockSharedPreferenceRepository),
        preferencesBloc: preferencesBloc,
      );
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
