import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preference_navigation/app/app.dart';
import 'package:preference_navigation/preferences/preferences.dart';

import '../../helpers/helpers.dart';

void main() {
  late MockPreferencesRepository mockPreferenceRepository;

  setUpAll(() {
    registerFallbackValue<PreferencesState>(FakePreferencesState());
    registerFallbackValue<PreferencesEvent>(FakePreferencesEvent());
  });

  group('App', () {
    setUp(() {
      mockPreferenceRepository = MockPreferencesRepository();
    });

    testWidgets('renders AppView', (tester) async {
      final preferencesBloc = MockPreferencesBloc();
      when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

      await tester.pumpApp(
        App(preferencesRepository: mockPreferenceRepository),
        preferencesBloc: preferencesBloc,
      );
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
