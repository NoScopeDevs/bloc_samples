import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    debugPrint('bloc: $bloc, error: $error, stackTrace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    debugPrint('bloc: $bloc, transition: $transition');
  }
}
