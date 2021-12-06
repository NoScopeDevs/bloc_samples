// ignore_for_file: prefer_const_constructors
import 'package:analytics_repository/analytics_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_analytics/app/bloc/app_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/hydrated_bloc.dart';

class MockAnalyticsRepository extends Mock implements AnalyticsRepository {}

class MockStorage extends Mock implements Storage {}

void main() {
  group('AppBloc', () {
    late AnalyticsRepository analyticsRepository;
    late Storage storage;

    setUp(() {
      analyticsRepository = MockAnalyticsRepository();
      storage = MockStorage();
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        mockHydratedStorage(() {
          final appBloc = AppBloc(
            localAnalyticsRepository: analyticsRepository,
          );
          expect(
            appBloc.fromJson(appBloc.toJson(appBloc.state)!),
            appBloc.state,
          );
        });
      });
    });

    test('initial state is correct', () {
      mockHydratedStorage(() {
        final appBloc = AppBloc(localAnalyticsRepository: analyticsRepository);
        expect(appBloc.state, AppInitial());
      });
    });

    test(
      'initial state should return [AppAnalyticsLoaded] '
      'when fromJson returns [AppAnalyticsLoaded]',
      () {
        mockHydratedStorage(
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
          storage: storage,
        );
      },
    );

    test(
      'initial state should return [AppAnalyticsError] '
      'when fromJson returns [AppAnalyticsError]',
      () {
        mockHydratedStorage(
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
          storage: storage,
        );
      },
    );

    group('AppAnalyticsChecked', () {
      blocTest<AppBloc, AppState>(
        'emits [AppAnalyticsLoaded] and increases and read openings '
        'when AppAnalyticsChecked is added',
        build: () => mockHydratedStorage(
          () => AppBloc(localAnalyticsRepository: analyticsRepository),
        ),
        setUp: () {
          when<dynamic>(() => storage.read('AppBloc')).thenReturn(null);
          when<dynamic>(
            () => storage.write('AppBloc', any<Map<String, dynamic>>()),
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
          when<dynamic>(
            () => storage.write('AppBloc', any<Map<String, dynamic>>()),
          ).thenAnswer((_) async {});
          when<void>(
            () => analyticsRepository.increaseOpeningsCount(),
          ).thenThrow(Exception());
          when(() => analyticsRepository.getOpeningsCount()).thenReturn(0);
        },
        build: () => mockHydratedStorage(
          () => AppBloc(localAnalyticsRepository: analyticsRepository),
        ),
        act: (bloc) => bloc.add(AppAnalyticsChecked()),
        expect: () => <AppState>[AppAnalyticsError()],
      );
    });
  });
}
