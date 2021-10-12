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
    if (state is ProfileInitial) {
      emit(
        ProfileLoaded(
          current: event.account,
          accounts: [event.account],
        ),
      );
    } else if (state is ProfileLoaded) {
      final _state = state as ProfileLoaded;
      emit(
        ProfileLoaded(
          current: _state.current,
          accounts: [..._state.accounts, event.account],
        ),
      );
    } else {
      emit(const ProfileError());
    }
  }

  void _onCurrentAccountChanged(
    ProfileCurrentAccountChanged event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      final _state = state as ProfileLoaded;
      emit(
        ProfileLoaded(
          current: event.account,
          accounts: _state.accounts,
        ),
      );
    } else {
      emit(const ProfileError());
    }
  }
}
