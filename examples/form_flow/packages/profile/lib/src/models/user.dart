import 'package:equatable/equatable.dart';

/// {@template user}
/// User model.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.email,
    required this.name,
    required this.biography,
    required this.pin,
  });

  /// Returns a [User] object with default properties.
  const User.empty() : this(email: '', name: '', biography: '', pin: '');

  /// The user's email address.
  final String email;

  /// The user's name.
  final String name;

  /// The user's biography.
  final String biography;

  /// The user's pin for his account.
  final String pin;

  @override
  List<Object> get props => [email, name, biography, pin];
}
