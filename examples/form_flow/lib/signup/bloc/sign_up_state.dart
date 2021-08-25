part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const EmailFormInput.pure(),
    this.name = const NameFormInput.pure(),
    this.biography = const BiographyFormInput.pure(),
    this.pin = const PinFormInput.pure(),
    this.status = FormzStatus.pure,
  });

  final EmailFormInput email;
  final NameFormInput name;
  final BiographyFormInput biography;
  final PinFormInput pin;
  final FormzStatus status;

  @override
  List<Object> get props => [email, name, biography, pin];

  SignUpState copyWith({
    EmailFormInput? email,
    NameFormInput? name,
    BiographyFormInput? biography,
    PinFormInput? pin,
    FormzStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      name: name ?? this.name,
      biography: biography ?? this.biography,
      pin: pin ?? this.pin,
      status: status ?? this.status,
    );
  }
}
