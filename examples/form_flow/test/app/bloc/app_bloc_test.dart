import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_flow/app/app.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppBloc', () {
    final user = MockUser();

    blocTest<AppBloc, AppState>(
      'emits [AppAuthenticated] when AppSignUpComplete is added.',
      build: AppBloc.new,
      act: (bloc) => bloc.add(AppSignUpCompleted(user)),
      expect: () => <AppState>[AppAuthenticated(user)],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppUnauthenticated] when AppLogoutRequested is added.',
      build: AppBloc.new,
      act: (bloc) => bloc.add(AppLogoutRequested()),
      expect: () => <AppState>[AppUnauthenticated()],
    );
  });
}
