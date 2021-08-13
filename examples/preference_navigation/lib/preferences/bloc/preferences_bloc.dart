import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:preferences_repository/preferences_repository.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

/// {@template preferences_bloc}
/// [Bloc] that handles preferences business logic.
/// {@endtemplate}
class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  /// {@macro preferences_bloc}
  PreferencesBloc({
    required PreferencesRepository repository,
  })  : _repository = repository,
        super(PreferencesInitial());

  final PreferencesRepository _repository;

  @override
  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    if (event is PreferenceAdded) {
      yield* _mapPreferenceAddedToState(event);
    } else if (event is PreferencesChecked) {
      yield* _mapPreferencesCheckedToState();
    } else if (event is PreferencesCleared) {
      yield* _mapPreferencesClearedToState();
    }
  }

  Stream<PreferencesState> _mapPreferenceAddedToState(
    PreferenceAdded event,
  ) async* {
    try {
      final key = event.entry.keys.first;
      final value = event.entry.values.first as Object;

      yield PreferencesLoading();
      await _repository.saveValue(key, value);

      yield* _mapPreferencesCheckedToState();
    } catch (e) {
      _handleError(e);
    }
  }

  Stream<PreferencesState> _mapPreferencesCheckedToState() async* {
    try {
      final keys = _repository.getKeys();
      if (keys.isEmpty) yield PreferencesEmpty();

      final preferences = <String, dynamic>{};
      for (final key in keys) {
        preferences.addAll(<String, dynamic>{key: _repository.getValue(key)});
      }

      yield PreferencesLoaded(preferences);
    } catch (e) {
      yield* _handleError(e);
    }
  }

  Stream<PreferencesState> _mapPreferencesClearedToState() async* {
    try {
      await _repository.clearValues();
      yield PreferencesEmpty();
    } catch (e) {
      _handleError(e);
    }
  }

  Stream<PreferencesState> _handleError(Object e) async* {
    if (e is PreferencesError) yield PreferencesError(e.error, e.stackTrace);
    yield const PreferencesError();
  }
}
