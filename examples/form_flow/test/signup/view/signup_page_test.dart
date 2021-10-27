// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/app/app.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile/profile.dart';

import '../../helpers/helpers.dart';

void main() {
  const user = User(
    email: 'marcos@noscope.dev',
    name: 'Marcos',
    biography: "I'm a software engineer",
    pin: '0123',
  );

  setUpAll(registerFallbackValues);

  group('SignUpPage', () {
    testWidgets(
      'adds AppSignUpCompleted when SignUpState is complete',
      (tester) async {
        final appBloc = MockAppBloc();
        final signUpBloc = MockSignUpBloc();
        whenListen(
          signUpBloc,
          Stream.fromIterable([SignUpState(user: user, complete: true)]),
          initialState: SignUpState(user: user),
        );

        await tester.pumpApp(
          BlocProvider<SignUpBloc>.value(
            value: signUpBloc,
            child: const SignUpView(),
          ),
          appBloc: appBloc,
        );

        verify(() => appBloc.add(AppSignUpCompleted(user))).called(1);
      },
    );
  });
}
