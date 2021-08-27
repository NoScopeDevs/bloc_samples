part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.profile = const User.empty(),
    this.complete = false,
  });

  final User profile;
  final bool complete;

  @override
  List<Object> get props => [profile];

  SignUpState copyWith({
    User? profile,
    bool? complete,
  }) {
    return SignUpState(
      profile: profile ?? this.profile,
      complete: complete ?? this.complete,
    );
  }
}
