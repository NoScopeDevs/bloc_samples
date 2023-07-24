part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

final class AppUnauthenticated extends AppState {}

final class AppAuthenticated extends AppState {
  const AppAuthenticated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
