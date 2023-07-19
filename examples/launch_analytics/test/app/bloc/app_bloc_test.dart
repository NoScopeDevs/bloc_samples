// ignore_for_file: prefer_const_constructors
import 'package:analytics_repository/analytics_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_analytics/app/bloc/app_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsRepository extends Mock implements AnalyticsRepository {}

class MockStorage extends Mock implements Storage {}

void main() {
  group('AppBloc', () {
    late AnalyticsRepository analyticsRepository;
    late Storage storage;

    setUp(() {
      analyticsRepository = MockAnalyticsRepository();
      storage = MockStorage();
      HydratedBloc.storage = storage;
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final appBloc = AppBloc(
          localAnalyticsRepository: analyticsRepository,
        );
        expect(
          appBloc.fromJson(appBloc.toJson(appBloc.state)!),
          appBloc.state,
        );
      });
    });

    test('initial state is correct', () {
      final appBloc = AppBloc(localAnalyticsRepository: analyticsRepository);
      expect(appBloc.state, AppInitial());
    });

    test(
      'initial state should return [AppAnalyticsLoaded] '
      'when fromJson returns [AppAnalyticsLoaded]',
      () {
        when<dynamic>(() => storage.read('AppBloc')).thenReturn({
          'runtimeType': 'AppAnalyticsLoaded',
          'openingCount': 100,
        });

        expect(
          AppBloc(
            localAnalyticsRepository: analyticsRepository,
          ).state,
          AppAnalyticsLoaded(100),
        );

        verify<dynamic>(() => storage.read('AppBloc')).called(1);
      },
    );

    test(
      'initial state should return [AppAnalyticsError] '
      'when fromJson returns [AppAnalyticsError]',
      () {
        when<dynamic>(() => storage.read('AppBloc')).thenReturn({
          'runtimeType': 'AppAnalyticsError',
        });

        expect(
          AppBloc(
            localAnalyticsRepository: analyticsRepository,
          ).state,
          AppAnalyticsError(),
        );

        verify<dynamic>(() => storage.read('AppBloc')).called(1);
      },
    );

    group('AppAnalyticsChecked', () {
      blocTest<AppBloc, AppState>(
        'emits [AppAnalyticsLoaded] and increases and read openings '
        'when AppAnalyticsChecked is added',
        build: () => AppBloc(localAnalyticsRepository: analyticsRepository),
        setUp: () {
          when<dynamic>(() => storage.read('AppBloc')).thenReturn(null);
          when<void>(
            () => storage.write(any(), any<dynamic>()),
          ).thenAnswer((_) async {});
          when<void>(
            () => analyticsRepository.increaseOpeningsCount(),
          ).thenReturn(null);
          when(() => analyticsRepository.getOpeningsCount()).thenReturn(0);
        },
        act: (bloc) => bloc.add(AppAnalyticsChecked()),
        expect: () => <AppState>[AppAnalyticsLoaded(0)],
      );

      blocTest<AppBloc, AppState>(
        'emits [AppAnalyticsError] '
        'when AppAnalyticsChecked is added',
        setUp: () {
          when<dynamic>(() => storage.read('AppBloc')).thenReturn(null);
          when<void>(
            () => storage.write(any(), any<dynamic>()),
          ).thenAnswer((_) async {});
          when<void>(
            () => analyticsRepository.increaseOpeningsCount(),
          ).thenThrow(Exception());
          when(() => analyticsRepository.getOpeningsCount()).thenReturn(0);
        },
        build: () => AppBloc(localAnalyticsRepository: analyticsRepository),
        act: (bloc) => bloc.add(AppAnalyticsChecked()),
        expect: () => <AppState>[AppAnalyticsError()],
      );
    });
  });
}
