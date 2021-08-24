import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preference_navigation/preferences/preferences.dart';
import 'package:preferences_repository/preferences_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late PreferencesRepository preferencesRepository;

  group('PreferencesBloc', () {
    const mockPreferences = {'key': 'value'};
    const mockSavedPreferences = {'key1': 'value1'};

    setUp(() {
      preferencesRepository = MockPreferencesRepository();
    });

    group('PreferenceAdded', () {
      blocTest<PreferencesBloc, PreferencesState>(
        'emits [PreferencesLoading, PreferencesLoaded] '
        'when PreferenceAdded is added.',
        setUp: () {
          when(preferencesRepository.getKeys).thenReturn(
            [mockSavedPreferences.keys.first, mockPreferences.keys.first],
          );
          when(() => preferencesRepository.saveValue(any(), any()))
              .thenAnswer((_) => Future<void>.value());
          when(
            () =>
                preferencesRepository.getValue(mockSavedPreferences.keys.first),
          ).thenReturn(mockSavedPreferences.values.first);
          when(
            () => preferencesRepository.getValue(mockPreferences.keys.first),
          ).thenReturn(mockPreferences.values.first);
        },
        build: () => PreferencesBloc(repository: preferencesRepository),
        act: (bloc) => bloc.add(const PreferenceAdded(mockPreferences)),
        expect: () => <PreferencesState>[
          const PreferencesLoading(),
          PreferencesLoaded(
            <String, dynamic>{
              mockSavedPreferences.keys.first:
                  mockSavedPreferences.values.first,
              mockPreferences.keys.first: mockPreferences.values.first,
            },
          ),
        ],
        verify: (bloc) => bloc.add(const PreferenceAdded(mockPreferences)),
      );

      blocTest<PreferencesBloc, PreferencesState>(
        'emits [PreferencesError] when preferencesRepository throws Exception.',
        setUp: () {
          when(preferencesRepository.getKeys).thenReturn(
            [mockSavedPreferences.keys.first, mockPreferences.keys.first],
          );
          when(() => preferencesRepository.saveValue(any(), any()))
              .thenThrow(Exception());
          when(
            () =>
                preferencesRepository.getValue(mockSavedPreferences.keys.first),
          ).thenReturn(mockSavedPreferences.values.first);
          when(
            () => preferencesRepository.getValue(mockPreferences.keys.first),
          ).thenReturn(mockPreferences.values.first);
        },
        build: () => PreferencesBloc(repository: preferencesRepository),
        act: (bloc) => bloc.add(const PreferenceAdded(mockPreferences)),
        expect: () => const <PreferencesState>[
          PreferencesLoading(),
          PreferencesError(),
        ],
        verify: (bloc) => bloc.add(const PreferenceAdded(mockPreferences)),
      );
    });

    group('PreferencesCleared', () {
      blocTest<PreferencesBloc, PreferencesState>(
        'emits [PreferencesEmpty] when PreferencesCleared is added.',
        setUp: () {
          when(
            () => preferencesRepository.clearValues(),
          ).thenAnswer((_) async {});
        },
        build: () => PreferencesBloc(repository: preferencesRepository),
        act: (bloc) => bloc.add(PreferencesCleared()),
        expect: () => const <PreferencesState>[PreferencesEmpty()],
      );

      blocTest<PreferencesBloc, PreferencesState>(
        'emits [PreferencesError] when preferencesRepository throws Exception.',
        setUp: () {
          when(() => preferencesRepository.clearValues())
              .thenThrow(Exception());
        },
        build: () => PreferencesBloc(repository: preferencesRepository),
        act: (bloc) => bloc.add(PreferencesCleared()),
        expect: () => const <PreferencesState>[PreferencesError()],
      );
    });
  });
}
