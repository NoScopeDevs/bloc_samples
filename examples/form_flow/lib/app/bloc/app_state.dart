part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppUnauthenticated extends AppState {}

class AppAuthenticated extends AppState {
  const AppAuthenticated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
