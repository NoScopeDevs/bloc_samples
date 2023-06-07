part of 'credentials_cubit.dart';

class CredentialsState extends Equatable {
  const CredentialsState({
    this.email = const EmailFormInput.pure(),
    this.name = const NameFormInput.pure(),
  });

  final EmailFormInput email;
  final NameFormInput name;

  @override
  List<Object> get props => [email, name];

  bool get isValid => email.isValid && name.isValid;

  bool get isPure => email.isPure && name.isPure;

  CredentialsState copyWith({
    EmailFormInput? email,
    NameFormInput? name,
  }) {
    return CredentialsState(
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
