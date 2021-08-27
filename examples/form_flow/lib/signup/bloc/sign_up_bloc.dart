import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile/profile.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpCredentialsSubmitted>(_onCredentialsSubmitted);
    on<SignUpBiographySubmitted>(_onBiographySubmitted);
    on<SignUpPinSubmitted>(_onPinSubmitted);
  }

  void _onCredentialsSubmitted(SignUpCredentialsSubmitted event, Emitter emit) {
    emit(
      state.copyWith(
        profile: Profile(
          email: event.email,
          name: event.name,
          biography: state.profile.biography,
          pin: state.profile.pin,
        ),
      ),
    );
  }

  void _onBiographySubmitted(SignUpBiographySubmitted event, Emitter emit) {
    emit(
      state.copyWith(
        profile: Profile(
          email: state.profile.email,
          name: state.profile.name,
          biography: event.biography,
          pin: state.profile.pin,
        ),
      ),
    );
  }

  void _onPinSubmitted(SignUpPinSubmitted event, Emitter emit) {
    emit(
      state.copyWith(
        profile: Profile(
          email: state.profile.email,
          name: state.profile.name,
          biography: state.profile.biography,
          pin: event.pin,
        ),
        complete: true,
      ),
    );
  }
}
