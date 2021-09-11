part of 'credentials_cubit.dart';

class CredentialsState extends Equatable {
  const CredentialsState({
    this.email = const EmailFormInput.pure(),
    this.name = const NameFormInput.pure(),
    this.status = FormzStatus.pure,
  });

  final EmailFormInput email;
  final NameFormInput name;
  final FormzStatus status;

  @override
  List<Object> get props => [email, name];

  CredentialsState copyWith({
    EmailFormInput? email,
    NameFormInput? name,
    FormzStatus? status,
  }) {
    return CredentialsState(
      email: email ?? this.email,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}
