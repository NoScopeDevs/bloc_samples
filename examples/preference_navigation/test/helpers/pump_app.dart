// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:preference_navigation/preferences/preferences.dart';
import 'package:preferences_repository/preferences_repository.dart';

import 'mocks.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    PreferencesRepository? preferencesRepository,
    PreferencesBloc? preferencesBloc,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: preferencesRepository ?? MockPreferencesRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: preferencesBloc ?? MockPreferencesBloc(),
            ),
          ],
          child: MaterialApp(
            home: widget,
          ),
        ),
      ),
    );
  }
}
