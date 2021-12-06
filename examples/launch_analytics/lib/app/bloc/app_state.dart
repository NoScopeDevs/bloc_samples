part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitial extends AppState {
  const AppInitial();

  @override
  List<Object?> get props => [];
}

class AppAnalyticsLoaded extends AppState {
  const AppAnalyticsLoaded(this.openingsCount);

  factory AppAnalyticsLoaded.fromJson(Map<String, dynamic> json) {
    return AppAnalyticsLoaded(json['openingCount'] as int);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'openingCount': openingsCount};
  }

  final int openingsCount;

  @override
  List<Object?> get props => [openingsCount];
}

class AppAnalyticsError extends AppState {
  const AppAnalyticsError();

  @override
  List<Object?> get props => [];
}
