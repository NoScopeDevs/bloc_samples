// ignore_for_file: prefer_const_constructors
import 'package:analytics_repository/analytics_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_analytics/app/bloc/app_bloc.dart';
import 'package:mocktail/mocktail.dart';

class FakeAppEvent extends Fake implements AppEvent {}

class FakeAppState extends Mock implements AppState {}

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

    test('storage getter returns correct storage instance', () {
      HydratedBlocOverrides.runZoned(
        () {
          when<dynamic>(() => storage.read('AppBloc')).thenReturn({
            'runtimeType': 'AppAnalyticsLoaded',
            'openingCount': 100,
          });
          when<dynamic>(
            () => storage.write('AppBloc', any<Map<String, dynamic>>()),
          ).thenAnswer((_) async {});
          expect(
            AppBloc(
              localAnalyticsRepository: analyticsRepository,
            ).state,
            AppAnalyticsLoaded(100),
          );

          verify<dynamic>(() => storage.read('AppBloc')).called(1);
          verify<dynamic>(
            () => storage.write('AppBloc', any<Map<String, dynamic>>()),
          ).called(1);
        },
        storage: storage,
      );
    });

    test(
      'initial state should return AppAnalyticsLoaded '
      'when fromJson returns AppAnalyticsLoaded',
      () {
        HydratedBlocOverrides.runZoned(
          () {
            when<dynamic>(() => storage.read('AppBloc')).thenReturn({
              'runtimeType': 'AppAnalyticsLoaded',
              'openingCount': 100,
            });
            when<dynamic>(
              () => storage.write('AppBloc', any<Map<String, dynamic>>()),
            ).thenAnswer((_) async {});
            expect(
              AppBloc(
                localAnalyticsRepository: analyticsRepository,
              ).state,
              AppAnalyticsLoaded(100),
            );

            verify<dynamic>(() => storage.read('AppBloc')).called(1);
            verify<dynamic>(
              () => storage.write('AppBloc', any<Map<String, dynamic>>()),
            ).called(1);
          },
          storage: storage,
        );
      },
    );

    test(
      'initial state should return AppAnalyticsError '
      'when fromJson returns AppAnalyticsError',
      () {
        HydratedBlocOverrides.runZoned(
          () {
            when<dynamic>(() => storage.read('AppBloc')).thenReturn({
              'runtimeType': 'AppAnalyticsError',
            });
            when<dynamic>(
              () => storage.write('AppBloc', any<Map<String, dynamic>>()),
            ).thenAnswer((_) async {});

            expect(
              AppBloc(
                localAnalyticsRepository: analyticsRepository,
              ).state,
              AppAnalyticsError(),
            );

            verify<dynamic>(() => storage.read('AppBloc')).called(1);
            verify<dynamic>(
              () => storage.write('AppBloc', any<Map<String, dynamic>>()),
            ).called(1);
          },
          storage: storage,
        );
      },
    );

    group('AppAnalyticsChecked', () {
      test(
        'emits [AppAnalyticsLoaded] and increases and read openings '
        'when AppAnalyticsChecked is added',
        () {
          HydratedBlocOverrides.runZoned(
            () async {
              when<dynamic>(() => storage.read('AppBloc')).thenReturn(null);
              when<dynamic>(
                () => storage.write('AppBloc', any<Map<String, dynamic>>()),
              ).thenAnswer((_) async {});
              when<void>(() => analyticsRepository.increaseOpeningsCount())
                  .thenReturn(null);
              when(() => analyticsRepository.getOpeningsCount()).thenReturn(0);

              final bloc = AppBloc(
                localAnalyticsRepository: analyticsRepository,
              );

              expect(bloc.state, AppInitial());

              bloc.add(AppAnalyticsChecked());

              await expectLater(
                bloc.stream,
                emitsInOrder(<AppState>[AppAnalyticsLoaded(0)]),
              );

              verify<dynamic>(() => storage.read('AppBloc')).called(1);
              verify<dynamic>(
                () => storage.write('AppBloc', any<Map<String, dynamic>>()),
              ).called(2);
            },
            storage: storage,
          );
        },
      );

      test(
          'emits [AppAnalyticsError] '
          'when AppAnalyticsChecked is added', () {
        HydratedBlocOverrides.runZoned(
          () async {
            when<dynamic>(() => storage.read('AppBloc')).thenReturn(null);
            when<dynamic>(
              () => storage.write('AppBloc', any<Map<String, dynamic>>()),
            ).thenAnswer((_) async {});
            when<void>(() => analyticsRepository.increaseOpeningsCount())
                .thenThrow(Exception());
            when(() => analyticsRepository.getOpeningsCount()).thenReturn(0);

            final bloc = AppBloc(localAnalyticsRepository: analyticsRepository);

            expect(bloc.state, AppInitial());

            bloc.add(AppAnalyticsChecked());

            await expectLater(
              bloc.stream,
              emitsInOrder(<AppState>[AppAnalyticsError()]),
            );
          },
          storage: storage,
        );
      });
    });
  });
}
