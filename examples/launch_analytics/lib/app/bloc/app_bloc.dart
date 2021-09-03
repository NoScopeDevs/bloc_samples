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
        super(const AppInitial()) {
    on<AppAnalyticsChecked>(_onAnalyticsChecked);
  }

  final AnalyticsRepository _localAnalyticsRepository;

  void _onAnalyticsChecked(
    AppAnalyticsChecked event,
    Emitter<AppState> emit,
  ) {
    try {
      _localAnalyticsRepository.increaseOpeningsCount();
      final openingsCount = _localAnalyticsRepository.getOpeningsCount();
      emit(AppAnalyticsLoaded(openingsCount));
    } catch (e) {
      emit(const AppAnalyticsError());
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
