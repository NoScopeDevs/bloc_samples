import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile/profile.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppUnauthenticated()) {
    on<AppSignUpCompleted>(_onSignUpComplete);
    on<AppLogoutRequested>(_onLogoutRequested);
  }

  void _onSignUpComplete(AppSignUpCompleted event, Emitter emit) {
    emit(AppAuthenticated(event.user));
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter emit) {
    emit(AppUnauthenticated());
  }
}
