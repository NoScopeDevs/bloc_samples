import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'nutrition_type.g.dart';

@JsonSerializable()
class NutritionType extends Equatable {
  const NutritionType({
    required this.name,
  });

  factory NutritionType.fromJson(Map<String, dynamic> json) =>
      _$NutritionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionTypeToJson(this);

  final String name;

  @override
  List<Object?> get props => [name];
}
