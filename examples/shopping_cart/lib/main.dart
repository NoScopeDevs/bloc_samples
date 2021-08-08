import 'package:flutter/material.dart';

import 'package:search_filter_repository/search_filter_repository.dart';

import 'package:shopping_cart/app/app.dart';

Future<void> main() async {
  const searchFilterRepository = SearchFilterRepository();

  runApp(const App(searchFilterRepository: searchFilterRepository));
}
