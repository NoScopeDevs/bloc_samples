import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';

enum AuthenticationState {
  authenticated,
  unauthenticated,
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState.unauthenticated);

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
