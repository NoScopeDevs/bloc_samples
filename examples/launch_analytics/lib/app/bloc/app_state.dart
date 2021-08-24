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

  factory AppAnalyticsLoaded.fromJson(Map<String, dynamic> json) {
    return AppAnalyticsLoaded(json['openingCount'] as int);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'openingCount': openingsCount,
      };

  final int openingsCount;
}

class AppAnalyticsError extends AppState {
  const AppAnalyticsError();
}
