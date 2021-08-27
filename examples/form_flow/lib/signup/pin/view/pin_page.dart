import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_flow/signup/signup.dart';

class PinPage extends StatelessWidget {
  const PinPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: PinPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PinCubit(),
      child: const PinView(),
    );
  }
}

class PinView extends StatelessWidget {
  const PinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$this'),
      ),
    );
  }
}
