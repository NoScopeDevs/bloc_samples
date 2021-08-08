import 'dart:async';

import 'package:analytics_repository/analytics_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
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

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    final runtimeType = json['runtimeType'] as String;

    switch (runtimeType) {
      case 'AppInitial':
        return const AppInitial();
      case 'AppAnalyticsLoaded':
        return AppAnalyticsLoaded.fromJson(json);
      case 'AppAnalyticsError':
        return const AppAnalyticsError();
    }
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    final map = <String, dynamic>{
      'runtimeType': '${state.runtimeType}',
    };

    if (state is AppAnalyticsLoaded) {
      map.addAll(state.toJson());
    }

    return map;
  }
}
