import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_filter_repository/search_filter_repository.dart';

part 'search_filter_event.dart';
part 'search_filter_state.dart';

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  SearchFilterBloc()
      : super(
          SearchFilterState(
            country: SearchFilterRepository.countries.first,
          ),
        );

  @override
  Stream<SearchFilterState> mapEventToState(
    SearchFilterEvent event,
  ) async* {
    if (event is SearchFilterCountrySelected) {
      yield _mapCountrySelectedToState(event);
    }
  }

  SearchFilterState _mapCountrySelectedToState(
      SearchFilterCountrySelected event) {
    return SearchFilterState(
      country: event.selectedCountry,
      categories: state.categories,
      nutritiontype: state.nutritiontype,
    );
  }
}
