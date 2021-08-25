import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: InfoPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('InfoPage'),
    );
  }
}
