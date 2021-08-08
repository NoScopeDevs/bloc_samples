part of 'search_filter_bloc.dart';

class SearchFilterState extends Equatable {
  const SearchFilterState({
    required this.country,
    this.categories = const [],
    this.nutritiontype = const [],
  });

  final Country country;
  final List<Category> categories;
  final List<NutritionType> nutritiontype;

  @override
  List<Object> get props => [
        country,
        categories,
        nutritiontype,
      ];
}
