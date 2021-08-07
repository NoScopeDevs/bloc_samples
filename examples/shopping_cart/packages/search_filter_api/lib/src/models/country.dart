import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'country.g.dart';

@JsonSerializable()
class Country extends Equatable {
  const Country({
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  final String name;

  @override
  List<Object?> get props => [name];
}
