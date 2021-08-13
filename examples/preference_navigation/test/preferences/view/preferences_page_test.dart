import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preference_navigation/preferences/preferences.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<PreferencesState>(FakePreferencesState());
    registerFallbackValue<PreferencesEvent>(FakePreferencesEvent());
  });

  group('PreferencesPage', () {
    testWidgets('renders PreferencesForm', (tester) async {
      final preferencesBloc = MockPreferencesBloc();
      when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

      await tester.pumpApp(
        const PreferencesPage(),
        preferencesBloc: preferencesBloc,
      );
      await tester.pump();
      expect(find.byType(PreferenceForm), findsOneWidget);
    });
  });
}
