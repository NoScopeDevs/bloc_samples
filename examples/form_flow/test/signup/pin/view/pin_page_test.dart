// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('PinPage', () {
    test('is routable', () {
      expect(PinPage.page(), isA<MaterialPage>());
    });

    testWidgets('renders PinView', (tester) async {
      await tester.pumpApp(const PinPage());
      expect(find.byType(PinView), findsOneWidget);
    });
  });

  group('PinInput', () {
    const pinInputKey = Key('pinView_pinInput_textField');

    testWidgets(
      'calls changePin when pin input changes',
      (tester) async {
        final pinCubit = MockPinCubit();
        when(() => pinCubit.state).thenReturn(const PinState());

        await tester.pumpApp(
          BlocProvider<PinCubit>.value(
            value: pinCubit,
            child: const PinView(),
          ),
        );
        await tester.enterText(find.byKey(pinInputKey), '0');

        verify(() => pinCubit.changePin(any())).called(1);
      },
    );

    testWidgets(
      'renders TextField with invalidPinInputErrorText '
      'when error is PinValidationError.invalid',
      (tester) async {
        final pinCubit = MockPinCubit();
        when(() => pinCubit.state).thenReturn(
          const PinState(
            pin: PinFormInput.dirty(),
            status: FormzStatus.invalid,
          ),
        );

        await tester.pumpApp(
          BlocProvider<PinCubit>.value(
            value: pinCubit,
            child: const PinView(),
          ),
        );

        final inputFinder = find.byKey(pinInputKey);
        final textField = tester.widget<TextField>(inputFinder);
        final context = tester.element(inputFinder);

        expect(
          textField.decoration!.errorText,
          context.l10n.invalidPinInputErrorText,
        );
      },
    );
  });

  group('SubmitButton', () {
    const submitButtonKey = Key('pinPage_submitButton_floatingActionButton');
    const pin = '0123';

    testWidgets(
      'adds SignUpPinSubmitted when pressing FloatingActionButton',
      (tester) async {
        final pinCubit = MockPinCubit();
        final signUpBloc = MockSignUpBloc();
        when(() => pinCubit.state).thenReturn(
          const PinState(
            pin: PinFormInput.dirty(pin),
            status: FormzStatus.valid,
          ),
        );

        await tester.pumpApp(
          MultiBlocProvider(
            providers: [
              BlocProvider<PinCubit>.value(value: pinCubit),
              BlocProvider<SignUpBloc>.value(value: signUpBloc),
            ],
            child: const PinView(),
          ),
        );
        await tester.ensureVisible(find.byKey(submitButtonKey));
        await tester.tap(find.byKey(submitButtonKey));

        verify(
          () => signUpBloc.add(SignUpPinSubmitted(pin)),
        ).called(1);
      },
    );
  });
}
