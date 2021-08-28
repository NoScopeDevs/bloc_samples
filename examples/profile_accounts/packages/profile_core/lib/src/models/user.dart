import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class User extends Equatable {
  User({
    required this.name,
    required this.email,
  }) : id = const Uuid().v4();

  final String id;
  final String name;
  final String email;

  @override
  List<Object> get props => [id, name, email];
}
