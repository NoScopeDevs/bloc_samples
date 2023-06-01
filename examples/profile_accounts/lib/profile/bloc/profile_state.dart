part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object?> get props => [];
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.current,
    required this.accounts,
  });

  final User current;
  final List<User> accounts;

  @override
  List<Object?> get props {
    return [
      current,
      accounts,
    ];
  }
}

final class ProfileError extends ProfileState {
  const ProfileError();

  @override
  List<Object?> get props => [];
}
