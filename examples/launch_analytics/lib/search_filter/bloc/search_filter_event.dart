part of 'search_filter_bloc.dart';

abstract class SearchFilterEvent extends Equatable {
  const SearchFilterEvent();
}

class SearchFilterCountrySelected extends SearchFilterEvent {
  const SearchFilterCountrySelected(this.selectedCountry);

  final Country selectedCountry;

  @override
  List<Object?> get props => [selectedCountry];
}
