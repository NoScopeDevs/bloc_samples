import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz_inputs/formz_inputs.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpNameChanged>(_onNameChanged);
    on<SignUpBioChanged>(_onBioChanged);
    on<SignUpPinChanged>(_onPinChanged);
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter emit) {
    final email = EmailFormInput.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.name, state.biography, state.pin]),
      ),
    );
  }

  void _onNameChanged(SignUpNameChanged event, Emitter emit) {
    final name = NameFormInput.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([state.email, name, state.biography, state.pin]),
      ),
    );
  }

  void _onBioChanged(SignUpBioChanged event, Emitter emit) {
    final biography = BiographyFormInput.dirty(event.biography);
    emit(
      state.copyWith(
        biography: biography,
        status: Formz.validate([state.email, state.name, biography, state.pin]),
      ),
    );
  }

  void _onPinChanged(SignUpPinChanged event, Emitter emit) {
    final pin = PinFormInput.dirty(event.pin);
    emit(
      state.copyWith(
        pin: pin,
        status: Formz.validate([state.email, state.name, state.biography, pin]),
      ),
    );
  }
}
