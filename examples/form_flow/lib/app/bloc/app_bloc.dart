import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile/profile.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppUnauthenticated()) {
    on<AppSignUpComplete>(_onSignUpComplete);
  }

  void _onSignUpComplete(AppSignUpComplete event, Emitter emit) {
    emit(AppAuthenticated(event.profile));
  }
}
