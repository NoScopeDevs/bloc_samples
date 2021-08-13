import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preference_navigation/preferences/preferences.dart';
import 'package:preferences_repository/preferences_repository.dart';

class MockPreferenceRepository extends Mock implements PreferencesRepository {}

void main() {
  late PreferencesRepository preferencesRepository;

  group('PreferencesBloc', () {
    const mockPreferences = {'key': 'value'};
    const mockSavedPreferences = {'key1': 'value1'};

    setUp(() {
      preferencesRepository = MockPreferenceRepository();
    });

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
          () => preferencesRepository.getValue(mockSavedPreferences.keys.first),
        ).thenReturn(mockSavedPreferences.values.first);
        when(
          () => preferencesRepository.getValue(mockPreferences.keys.first),
        ).thenReturn(mockPreferences.values.first);
      },
      build: () => PreferencesBloc(repository: preferencesRepository),
      act: (bloc) => bloc.add(const PreferenceAdded(mockPreferences)),
      expect: () => <PreferencesState>[
        PreferencesLoading(),
        PreferencesLoaded(
          <String, dynamic>{
            mockSavedPreferences.keys.first: mockSavedPreferences.values.first,
            mockPreferences.keys.first: mockPreferences.values.first,
          },
        ),
      ],
      verify: (bloc) => bloc.add(const PreferenceAdded(mockPreferences)),
    );
  });
}
