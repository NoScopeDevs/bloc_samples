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
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(
        ProfileLoaded(
          current: loadedState.current,
          accounts: [...loadedState.accounts, event.account],
        ),
      );
    } else {
      emit(
        ProfileLoaded(
          current: event.account,
          accounts: [event.account],
        ),
      );
    }
  }

  void _onCurrentAccountChanged(
    ProfileCurrentAccountChanged event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(
        ProfileLoaded(
          current: event.account,
          accounts: loadedState.accounts,
        ),
      );
    } else {
      emit(const ProfileError());
    }
  }
}
