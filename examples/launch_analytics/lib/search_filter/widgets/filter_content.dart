import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_analytics/search_filter/bloc/search_filter_bloc.dart';
import 'package:launch_analytics/search_filter/search_filter.dart';

class FilterContent extends StatelessWidget {
  const FilterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchFilterBloc(),
      child: const FilterContentView(),
    );
  }
}

class FilterContentView extends StatelessWidget {
  const FilterContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .85,
      child: Center(
        child: Column(
          children: const <Widget>[
            FilterTitle(),
            FilterOptions(),
          ],
        ),
      ),
    );
  }
}

class FilterTitle extends StatelessWidget {
  const FilterTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.cancel),
        ),
        const Text('Filter'),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
