import 'package:flutter/material.dart';
import 'package:launch_analytics/search_filter/search_filter.dart';

///HomePage
class HomePage extends StatelessWidget {
  ///HomePage constructor
  const HomePage({Key? key}) : super(key: key);

  ///HomePage [routeName]
  static const routeName = 'HomePage';

  ///Router for HomePage
  static Route go() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return const FilterContent();
                },
              );
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
      ),
    );
  }
}
