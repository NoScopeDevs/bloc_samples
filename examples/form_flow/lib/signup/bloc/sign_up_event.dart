part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpCredentialsSubmitted extends SignUpEvent {
  const SignUpCredentialsSubmitted({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  List<Object> get props => [email, name];
}

class SignUpBiographySubmitted extends SignUpEvent {
  const SignUpBiographySubmitted(this.biography);

  final String biography;

  @override
  List<Object> get props => [biography];
}

class SignUpPinSubmitted extends SignUpEvent {
  const SignUpPinSubmitted(this.pin);

  final String pin;

  @override
  List<Object> get props => [pin];
}
