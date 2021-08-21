import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preference_navigation/app/app_hive.dart';
import 'package:preference_navigation/preferences/preferences.dart';

import '../../helpers/helpers.dart';

void main() {
  late MockHivePreferencesRepository mockHivePreferenceRepository;

  setUpAll(() {
    registerFallbackValue<PreferencesState>(FakePreferencesState());
    registerFallbackValue<PreferencesEvent>(FakePreferencesEvent());
  });

  group('App with Hive implementation', () {
    setUp(() {
      mockHivePreferenceRepository = MockHivePreferencesRepository();
    });

    testWidgets('renders AppView with HivePreferencesRepository  instance',
        (tester) async {
      final preferencesBloc = MockPreferencesBloc();
      when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

      await tester.pumpApp(
        App(preferencesRepository: mockHivePreferenceRepository),
        preferencesRepository: mockHivePreferenceRepository,
        preferencesBloc: preferencesBloc,
      );
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
