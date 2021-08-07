part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppAnalyticsChecked extends AppEvent {
  const AppAnalyticsChecked();
}
