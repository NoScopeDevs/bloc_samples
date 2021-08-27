part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.user = const User.empty(),
    this.complete = false,
  });

  final User user;
  final bool complete;

  @override
  List<Object> get props => [user];

  SignUpState copyWith({
    User? user,
    bool? complete,
  }) {
    return SignUpState(
      user: user ?? this.user,
      complete: complete ?? this.complete,
    );
  }
}
