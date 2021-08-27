import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/signup/signup.dart';

class BiographyPage extends StatelessWidget {
  const BiographyPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: BiographyPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BiographyCubit(),
      child: const BiographyView(),
    );
  }
}

class BiographyView extends StatelessWidget {
  const BiographyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$this'),
      ),
    );
  }
}
