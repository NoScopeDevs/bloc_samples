import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile_core/profile_core.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    on<ProfileAccountAdded>(_onAccountAdded);
    on<ProfileCurrentAccountChanged>(_onCurrentAccountChanged);
  }

  void _onAccountAdded(ProfileAccountAdded event, Emitter<ProfileState> emit) {
    switch (state) {
      case ProfileInitial():
        emit(
          ProfileLoaded(
            current: event.account,
            accounts: [event.account],
          ),
        );
      case ProfileLoaded(current: final current, accounts: final accounts):
        emit(
          ProfileLoaded(
            current: current,
            accounts: [...accounts, event.account],
          ),
        );
      case ProfileError():
        emit(const ProfileError());
    }
  }

  void _onCurrentAccountChanged(
    ProfileCurrentAccountChanged event,
    Emitter<ProfileState> emit,
  ) {
    switch (state) {
      case ProfileLoaded(accounts: final accounts):
        emit(
          ProfileLoaded(
            current: event.account,
            accounts: accounts,
          ),
        );
      default:
        emit(const ProfileError());
    }
  }
}
