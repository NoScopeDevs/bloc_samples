part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppSignUpComplete extends AppEvent {
  const AppSignUpComplete(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
