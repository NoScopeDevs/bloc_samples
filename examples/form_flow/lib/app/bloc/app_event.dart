part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class AppLogoutRequested extends AppEvent {}

final class AppSignUpCompleted extends AppEvent {
  const AppSignUpCompleted(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
