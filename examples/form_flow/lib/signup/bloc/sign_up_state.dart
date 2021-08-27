part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.profile = const Profile.empty(),
    this.complete = false,
  });

  final Profile profile;
  final bool complete;

  @override
  List<Object> get props => [profile];

  SignUpState copyWith({
    Profile? profile,
    bool? complete,
  }) {
    return SignUpState(
      profile: profile ?? this.profile,
      complete: complete ?? this.complete,
    );
  }
}
