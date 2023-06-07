import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/l10n/l10n.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  final validBiography = String.fromCharCodes(
    Iterable.generate(140, (_) => 1),
  );
  final invalidBiography = String.fromCharCodes(
    Iterable.generate(142, (_) => 1),
  );

  group('BiographyPage', () {
    test('is routable', () {
      expect(BiographyPage.page(), isA<MaterialPage<void>>());
    });

    testWidgets('renders BiographyView', (tester) async {
      await tester.pumpApp(const BiographyPage());
      expect(find.byType(BiographyView), findsOneWidget);
    });
  });

  group('BiographyInput', () {
    const biographyInputKey = Key('biographyView_biographyInput_textField');

    testWidgets(
      'calls changeBiography when biography input changes',
      (tester) async {
        final biographyCubit = MockBiographyCubit();
        when(() => biographyCubit.state).thenReturn(const BiographyState());

        await tester.pumpApp(
          BlocProvider<BiographyCubit>.value(
            value: biographyCubit,
            child: const BiographyView(),
          ),
        );
        await tester.enterText(find.byKey(biographyInputKey), 'M');

        verify(() => biographyCubit.changeBiography(any())).called(1);
      },
    );

    testWidgets(
      'renders TextField with emptyBiographyInputErrorText '
      'when error is BiographyValidationError.empty',
      (tester) async {
        final biographyCubit = MockBiographyCubit();
        when(() => biographyCubit.state).thenReturn(
          const BiographyState(
            biography: BiographyFormInput.dirty(),
          ),
        );

        await tester.pumpApp(
          BlocProvider<BiographyCubit>.value(
            value: biographyCubit,
            child: const BiographyView(),
          ),
        );

        final inputFinder = find.byKey(biographyInputKey);
        final textField = tester.widget<TextField>(inputFinder);
        final context = tester.element(inputFinder);

        expect(
          textField.decoration!.errorText,
          context.l10n.emptyBiographyInputErrorText,
        );
      },
    );

    testWidgets(
      'renders TextField with longBiographyInputErrorText '
      'when error is BiographyValidationError.tooLong',
      (tester) async {
        final biographyCubit = MockBiographyCubit();
        when(() => biographyCubit.state).thenReturn(
          BiographyState(
            biography: BiographyFormInput.dirty(invalidBiography),
          ),
        );

        await tester.pumpApp(
          BlocProvider<BiographyCubit>.value(
            value: biographyCubit,
            child: const BiographyView(),
          ),
        );

        final inputFinder = find.byKey(biographyInputKey);
        final textField = tester.widget<TextField>(inputFinder);
        final context = tester.element(inputFinder);

        expect(
          textField.decoration!.errorText,
          context.l10n.longBiographyInputErrorText,
        );
      },
    );
  });

  group('SubmitButton', () {
    const submitButtonKey =
        Key('biographyPage_submitButton_floatingActionButton');

    testWidgets(
      'adds SignUpBiographySubmitted when pressing FloatingActionButton',
      (tester) async {
        final biographyCubit = MockBiographyCubit();
        final signUpBloc = MockSignUpBloc();
        when(() => biographyCubit.state).thenReturn(
          BiographyState(
            biography: BiographyFormInput.dirty(validBiography),
          ),
        );

        await tester.pumpApp(
          MultiBlocProvider(
            providers: [
              BlocProvider<BiographyCubit>.value(value: biographyCubit),
              BlocProvider<SignUpBloc>.value(value: signUpBloc),
            ],
            child: const BiographyView(),
          ),
        );
        await tester.ensureVisible(find.byKey(submitButtonKey));
        await tester.tap(find.byKey(submitButtonKey));

        verify(
          () => signUpBloc.add(SignUpBiographySubmitted(validBiography)),
        ).called(1);
      },
    );
  });
}
