part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {
  const AppInitial();
}

class AppAnalyticsLoaded extends AppState {
  const AppAnalyticsLoaded(this.openingsCount);
  final int openingsCount;
}

class AppAnalyticsError extends AppState {
  const AppAnalyticsError();
}
