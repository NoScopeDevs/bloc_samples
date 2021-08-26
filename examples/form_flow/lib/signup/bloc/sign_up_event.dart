part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class SignUpNameChanged extends SignUpEvent {
  const SignUpNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class SignUpBioChanged extends SignUpEvent {
  const SignUpBioChanged(this.biography);

  final String biography;

  @override
  List<Object> get props => [biography];
}

class SignUpPinChanged extends SignUpEvent {
  const SignUpPinChanged(this.pin);

  final String pin;

  @override
  List<Object> get props => [pin];
}
