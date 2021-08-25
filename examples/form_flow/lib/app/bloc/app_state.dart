part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppUnauthenticated extends AppState {}

class AppAuthenticated extends AppState {}
