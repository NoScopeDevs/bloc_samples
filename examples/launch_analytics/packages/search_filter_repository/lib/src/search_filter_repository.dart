import 'package:search_filter_api/search_filter_api.dart';

/// {@template search_filter_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class SearchFilterRepository {
  /// {@macro search_filter_repository}
  const SearchFilterRepository();

  static const List<Country> countries = [
    Country(name: 'USA'),
    Country(name: 'Nicaragua'),
    Country(name: 'Costa Rica'),
  ];

  static const List<Category> categories = [
    Category(name: 'Italian'),
    Category(name: 'Pizza'),
    Category(name: 'Vegan'),
    Category(name: 'Vegetarian'),
  ];

  static const List<NutritionType> nutritionType = [
    NutritionType(name: 'Glute Free'),
    NutritionType(name: 'Alcohol Free'),
  ];
}
