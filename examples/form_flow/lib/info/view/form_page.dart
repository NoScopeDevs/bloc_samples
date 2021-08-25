import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: FormPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('FormPage'),
    );
  }
}
