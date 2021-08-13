import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preference_navigation/preferences/preferences.dart';
import 'package:preference_navigation/start/start.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<PreferencesState>(FakePreferencesState());
    registerFallbackValue<PreferencesEvent>(FakePreferencesEvent());
  });

  group('StartPage', () {
    testWidgets('renders StartView', (tester) async {
      final preferencesBloc = MockPreferencesBloc();
      when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

      await tester.pumpApp(
        const StartPage(),
        preferencesBloc: preferencesBloc,
      );
      await tester.pump();
      expect(find.byType(StartView), findsOneWidget);
    });
  });
}
