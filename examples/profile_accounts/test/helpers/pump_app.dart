import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_accounts/profile/profile.dart';

import 'helpers.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {ProfileBloc? profileBloc}) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>.value(
            value: profileBloc ?? MockProfileBloc(),
          ),
        ],
        child: MaterialApp(
          home: widget,
        ),
      ),
    );
  }
}
