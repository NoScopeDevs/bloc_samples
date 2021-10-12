// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:launch_analytics/app/bloc/app_bloc.dart';

void main() {
  group('AppEvent', () {
    group('AppAnalyticsChecked', () {
      test('supports value comparisons', () {
        expect(AppAnalyticsChecked(), AppAnalyticsChecked());
      });
    });
  });
}
