import 'dart:io';

import 'package:args/command_runner.dart';

import 'package:utils/commands/cov/commands/merge.dart';

/// Provides `lcov.info` files utils.
Future<void> run(List<String> args) async {
  try {
    final runner = CommandRunner<void>(
      'cov',
      'A set of handy commands to manipulate `lcov.info` files.',
    )..addCommand(MergeCommand());

    await runner.run(args);
  } catch (e) {
    stdout.write('$e');
    exitCode = 1;
  }
}
