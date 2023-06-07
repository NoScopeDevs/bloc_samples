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

  void _onCredentialsSubmitted(
    SignUpCredentialsSubmitted event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        user: User(
          email: event.email,
          name: event.name,
          biography: state.user.biography,
          pin: state.user.pin,
        ),
      ),
    );
  }

  void _onBiographySubmitted(
    SignUpBiographySubmitted event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        user: User(
          email: state.user.email,
          name: state.user.name,
          biography: event.biography,
          pin: state.user.pin,
        ),
      ),
    );
  }

  void _onPinSubmitted(
    SignUpPinSubmitted event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        user: User(
          email: state.user.email,
          name: state.user.name,
          biography: state.user.biography,
          pin: event.pin,
        ),
        complete: true,
      ),
    );
  }
}
