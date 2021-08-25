import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_filter_repository/search_filter_repository.dart';
import 'package:shopping_cart/home/home.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required SearchFilterRepository searchFilterRepository,
  })  : _searchFilterRepository = searchFilterRepository,
        super(key: key);

  final SearchFilterRepository _searchFilterRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _searchFilterRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
