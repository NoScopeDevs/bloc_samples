part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppUnauthenticated extends AppState {}

class AppAuthenticated extends AppState {
  const AppAuthenticated(this.profile);

  final Profile profile;

  @override
  List<Object> get props => [profile];
}
