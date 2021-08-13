import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
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
    test('is routable', () {
      expect(HomePage.go(), isA<MaterialPageRoute>());
    });

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

  group('HomeView', () {
    testWidgets(
      'adds PreferencesCleared when IconButton is pressed',
      (tester) async {
        final preferencesBloc = MockPreferencesBloc();
        when(() => preferencesBloc.state).thenReturn(FakePreferencesState());

        await tester.pumpApp(
          const HomeView(),
          preferencesBloc: preferencesBloc,
        );
        await tester.pump();
        await tester.tap(find.byType(IconButton));
        verify(() => preferencesBloc.add(PreferencesCleared()));
      },
    );

    testWidgets(
      'navigates when PreferencesEmpty is emitted',
      (tester) async {
        final navigator = MockNavigator();
        when(() => navigator.push(any())).thenAnswer((_) async {});

        final preferencesBloc = MockPreferencesBloc();
        when(() => preferencesBloc.state).thenReturn(FakePreferencesState());
        whenListen(
          preferencesBloc,
          Stream.fromIterable([PreferencesEmpty()]),
          initialState: PreferencesInitial(),
        );

        await tester.pumpApp(
          MockNavigatorProvider(
            navigator: navigator,
            child: const HomeView(),
          ),
          preferencesBloc: preferencesBloc,
        );
        verify(() => navigator.push(any(that: isRoute<void>()))).called(1);
      },
    );
  });
}
