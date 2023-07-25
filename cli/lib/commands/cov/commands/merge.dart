import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

/// {@template merge_command}
/// A command to merge coverage data.
/// {@endtemplate}
class MergeCommand extends Command<void> {
  /// {@macro merge_command}
  MergeCommand() {
    argParser
      ..addMultiOption(
        _ignorePatternsOption,
        abbr: 'i',
        help: '''
Set of comma-separated path patterns of the files to be ignored from the coverage data file.
Consider that each file coverage data is checked as a multiline block, where each bloc starts with `$_kFileCovDataRecordStart` and ends with `$_kFileCovDataRecordEnd`.''',
        defaultsTo: [],
        valueHelp: _ignorePatternsHelpValue,
      )
      ..addOption(
        _originOption,
        abbr: 'o',
        help: 'Origin `lcov.info` file to pick coverage data from.',
        defaultsTo: 'coverage/lcov.info',
        valueHelp: _originHelpValue,
      )
      ..addOption(
        _destinationOption,
        abbr: 'd',
        help:
            '''Destination `lcov.info` file to dump the resulting coverage data into.''',
        defaultsTo: 'coverage/wiped.lcov.info',
        valueHelp: _destinationHelpValue,
      );
  }

  static const _ignorePatternsHelpValue = 'PATTERNS';
  static const _originHelpValue = 'ORIGIN_LCOV_FILE';
  static const _destinationHelpValue = 'DESTINATION_LCOV_FILE';

  static const _ignorePatternsOption = 'ignore-patterns';
  static const _originOption = 'origin';
  static const _destinationOption = 'destination';

  @override
  String get description => '''
Merge coverage data ignoring info related to files with paths that matches the given $_ignorePatternsHelpValue. The coverage data is removed from the $_originHelpValue file and the result is appended to the $_destinationHelpValue file.''';

  @override
  String get name => 'merge';

  @override
  List<String> get aliases => ['m'];

  static const _kFileCovDataRecordStart = 'SF:';
  static const _kFileCovDataRecordEnd = 'end_of_record';

  static const _kMelosRootPathKey = 'MELOS_ROOT_PATH';

  @override
  Future<void> run() async {
    // Retrieve arguments and validate their value and the state they represent.
    final argumentResults = ArgumentError.checkNotNull(argResults);

    final originPath = ArgumentError.checkNotNull(
      argumentResults[_originOption],
    ) as String;
    final destinationPath = ArgumentError.checkNotNull(
      argumentResults[_destinationOption],
    ) as String;
    final ignorePatterns = ArgumentError.checkNotNull(
      argumentResults[_ignorePatternsOption],
    ) as List<String>;

    final envVars = Platform.environment;
    final melosRootPath = ArgumentError.checkNotNull(
      envVars[_kMelosRootPathKey],
    );

    final origin = File(originPath);
    final destination = File(destinationPath);
    final pwd = Directory.current;

    if (!origin.existsSync()) {
      throw StateError('The `$originPath` file does not exist.');
    }

    // Construct the package folder path relative to the project root folder.
    final packageRelativePath = path.relative(
      pwd.path,
      from: melosRootPath,
    );

    // Get initial package coverage data.
    final initialContent = origin.readAsStringSync().trim();
    final finalContentBuf = StringBuffer();

    // Split coverage data by the files they cover.
    final filesCovData = initialContent //
        .split(_kFileCovDataRecordEnd) //
        .map((s) => s.trim()) //
        .where((s) => s.isNotEmpty);

    // For each file coverage data.
    for (final fileCovData in filesCovData) {
      // Check if file should be ignored according to matching patterns.
      var shouldBeIgnored = false;
      for (final ignorePattern in ignorePatterns) {
        final regexp = RegExp(ignorePattern);
        shouldBeIgnored |= regexp.hasMatch(fileCovData);
      }

      // Conditionaly include file coverage data.
      if (shouldBeIgnored) {
        const dartExtension = '.dart';
        final fileStartIdx = fileCovData.indexOf(_kFileCovDataRecordStart) +
            _kFileCovDataRecordStart.length;
        final fileEndIdx = fileCovData.indexOf(dartExtension);

        final ignoredFile = fileCovData.substring(fileStartIdx, fileEndIdx);

        print('<$ignoredFile$dartExtension> coverage data ignored.');
      } else {
        finalContentBuf
          ..writeln(
            fileCovData.replaceAll(
              RegExp(_kFileCovDataRecordStart),
              '$_kFileCovDataRecordStart$packageRelativePath${path.separator}',
            ),
          )
          ..writeln(_kFileCovDataRecordEnd);
      }
    }

    // Generate destination file and its content.
    destination
      ..createSync(recursive: true)
      ..writeAsStringSync(
        finalContentBuf.toString(),
        mode: FileMode.append,
        flush: true,
      );
  }
}
