// stores ExpansionPanel state information
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_filter_repository/search_filter_repository.dart';
import 'package:shopping_cart/search_filter/bloc/search_filter_bloc.dart';

class Item {
  Item({
    required this.headerValue,
    this.isExpanded = false,
  });

  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
    );
  });
}

/// This is the stateful widget that the main application instantiates.
class FilterOptions extends StatefulWidget {
  const FilterOptions({Key? key}) : super(key: key);

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _FilterOptionsState extends State<FilterOptions> {
  final List<bool> _isExpandedList = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpandedList[index] = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return const ListTile(
                title: Text('Option 1'),
              );
            },
            body: BlocSelector<SearchFilterBloc, SearchFilterState, Country>(
              selector: (state) => state.country,
              builder: (context, selectedCountry) => ListView.builder(
                shrinkWrap: true,
                itemCount: SearchFilterRepository.countries.length,
                itemBuilder: (context, index) {
                  final country = SearchFilterRepository.countries[index];
                  return Container(
                    color: country == selectedCountry
                        ? Colors.green
                        : Colors.transparent,
                    child: ListTile(
                      onTap: () {
                        context.read<SearchFilterBloc>().add(
                              SearchFilterCountrySelected(country),
                            );
                      },
                      title: Text(country.name),
                    ),
                  );
                },
              ),
            ),
            isExpanded: _isExpandedList[0],
          ),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return const ListTile(
                title: Text('Option 2'),
              );
            },
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: SearchFilterRepository.categories.length,
              itemBuilder: (context, index) {
                final category = SearchFilterRepository.categories[index];
                return ListTile(
                  title: Text(category.name),
                );
              },
            ),
            isExpanded: _isExpandedList[1],
          ),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return const ListTile(
                title: Text('Option 3'),
              );
            },
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: SearchFilterRepository.nutritionType.length,
              itemBuilder: (context, index) {
                final nutritionType =
                    SearchFilterRepository.nutritionType[index];
                return ListTile(
                  title: Text(nutritionType.name),
                );
              },
            ),
            isExpanded: _isExpandedList[2],
          ),
        ],
      ),
    );
  }
}
