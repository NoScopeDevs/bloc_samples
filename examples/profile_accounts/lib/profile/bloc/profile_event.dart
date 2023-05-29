part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileAccountAdded extends ProfileEvent {
  const ProfileAccountAdded(this.account);

  final User account;

  @override
  List<Object?> get props => [account];
}

final class ProfileCurrentAccountChanged extends ProfileEvent {
  const ProfileCurrentAccountChanged(this.account);

  final User account;

  @override
  List<Object?> get props => [account];
}
