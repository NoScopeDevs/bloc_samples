import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile_core/profile_core.dart';
export 'package:profile_core/profile_core.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileAccountAdded) {
      yield _mapAccountAddedToState(event, state);
    } else if (event is ProfileCurrentAccountChanged) {
      yield _mapCurrentAccountChangedToState(event, state);
    }
  }

  ProfileState _mapAccountAddedToState(
    ProfileAccountAdded event,
    ProfileState state,
  ) {
    if (state is ProfileInitial) {
      return ProfileLoaded(
        current: event.account,
        accounts: [event.account],
      );
    } else if (state is ProfileLoaded) {
      return ProfileLoaded(
        current: state.current,
        accounts: [...state.accounts, event.account],
      );
    } else {
      return const ProfileError();
    }
  }

  ProfileState _mapCurrentAccountChangedToState(
    ProfileCurrentAccountChanged event,
    ProfileState state,
  ) {
    if (state is ProfileLoaded) {
      return ProfileLoaded(
        current: event.account,
        accounts: state.accounts,
      );
    } else {
      return const ProfileError();
    }
  }
}
