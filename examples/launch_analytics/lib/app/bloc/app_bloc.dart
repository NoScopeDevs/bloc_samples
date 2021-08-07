import 'dart:async';

import 'package:analytics_repository/analytics_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AnalyticsRepository localAnalyticsRepository,
  })  : _localAnalyticsRepository = localAnalyticsRepository,
        super(const AppInitial());

  final AnalyticsRepository _localAnalyticsRepository;

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppAnalyticsChecked) {
      yield* _mapAnalyticsChecked(event);
    }
  }

  Stream<AppState> _mapAnalyticsChecked(AppAnalyticsChecked event) async* {
    try {
      _localAnalyticsRepository.increaseOpeningsCount();
      final openingsCount = _localAnalyticsRepository.getOpeningsCount();
      yield AppAnalyticsLoaded(openingsCount);
    } catch (e) {
      yield const AppAnalyticsError();
    }
  }
}
