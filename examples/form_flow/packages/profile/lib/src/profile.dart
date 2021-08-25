import 'package:equatable/equatable.dart';

/// {@template profile}
/// Profile model.
/// {@endtemplate}
class Profile extends Equatable {
  /// {@macro profile}
  const Profile({
    required this.email,
    required this.name,
    required this.biography,
    required this.pin,
  });

  /// The user's email address.
  final String email;

  /// The user's name.
  final String name;

  /// The user's biography.
  final String biography;

  /// The user's pin for his account.
  final String pin;

  @override
  List<Object> get props => [email, name, biography];
}
