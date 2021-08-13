import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preference_navigation/home/home.dart';
import 'package:preference_navigation/preferences/preferences.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<PreferencesState>(FakePreferencesState());
    registerFallbackValue<PreferencesEvent>(FakePreferencesEvent());
  });

  group('HomePage', () {
    testWidgets('renders HomePage', (tester) async {
      final preferencesBloc = MockPreferencesBloc();
      when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

      await tester.pumpApp(
        const HomePage(),
        preferencesBloc: preferencesBloc,
      );
      await tester.pump();
      expect(find.byType(HomeView), findsOneWidget);
    });
  });
}
