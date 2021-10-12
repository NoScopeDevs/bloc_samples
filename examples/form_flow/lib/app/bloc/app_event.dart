part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppSignUpCompleted extends AppEvent {
  const AppSignUpCompleted(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
