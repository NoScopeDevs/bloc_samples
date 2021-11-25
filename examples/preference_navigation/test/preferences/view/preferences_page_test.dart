import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:preference_navigation/preferences/preferences.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PreferencesPage', () {
    testWidgets('renders PreferencesForm', (tester) async {
      final preferencesBloc = MockPreferencesBloc();
      when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

      await tester.pumpApp(
        const PreferencesPage(),
        preferencesBloc: preferencesBloc,
      );
      expect(find.byType(PreferencesForm), findsOneWidget);
    });

    testWidgets('navigates when PreferencesLoaded is emitted', (tester) async {
      final navigator = MockNavigator();
      when(() => navigator.push(any())).thenAnswer((_) async {});

      final preferencesBloc = MockPreferencesBloc();
      whenListen(
        preferencesBloc,
        Stream.fromIterable(const [
          PreferencesLoaded(<String, dynamic>{'key': 'value'}),
        ]),
        initialState: const PreferencesInitial(),
      );

      await tester.pumpApp(
        MockNavigatorProvider(
          navigator: navigator,
          child: const PreferencesPage(),
        ),
        preferencesBloc: preferencesBloc,
      );
      verify(() => navigator.push(any(that: isRoute<void>()))).called(1);
    });

    testWidgets(
      'replaces route when PreferencesError is emitted',
      (tester) async {
        final navigator = MockNavigator();
        when(() => navigator.pushReplacement(any())).thenAnswer((_) async {});

        final preferencesBloc = MockPreferencesBloc();
        whenListen(
          preferencesBloc,
          Stream.fromIterable(const [PreferencesError()]),
          initialState: const PreferencesInitial(),
        );

        await tester.pumpApp(
          MockNavigatorProvider(
            navigator: navigator,
            child: const PreferencesPage(),
          ),
          preferencesBloc: preferencesBloc,
        );
        verify(
          () => navigator.pushReplacement(any(that: isRoute<void>())),
        ).called(1);
      },
    );
  });

  group('PreferencesForm', () {
    const mockPreferences = {'key': 'value'};

    const preferenceKeyInputKey = Key('preferencesForm_keyInput_textField');
    const preferenceValueInputKey = Key('preferencesForm_valueInput_textField');
    const preferencesSaveButtonKey = Key('preferencesForm_save_elevatedButton');

    testWidgets(
      'adds PreferenceAdded when pressing ElevatedButton',
      (tester) async {
        final preferencesBloc = MockPreferencesBloc();

        await tester.pumpApp(
          const Material(
            child: PreferencesForm(),
          ),
          preferencesBloc: preferencesBloc,
        );
        await tester.enterText(
          find.byKey(preferenceKeyInputKey),
          mockPreferences.entries.first.key,
        );
        await tester.enterText(
          find.byKey(preferenceValueInputKey),
          mockPreferences.entries.first.value,
        );
        await tester.ensureVisible(find.byKey(preferencesSaveButtonKey));
        await tester.tap(find.byKey(preferencesSaveButtonKey));

        verify(
          () => preferencesBloc.add(const PreferenceAdded(mockPreferences)),
        ).called(1);
      },
    );
  });
}
