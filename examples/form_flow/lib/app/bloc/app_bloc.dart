import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppUnauthenticated());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    // TODO: implement mapEventToState
  }
}
