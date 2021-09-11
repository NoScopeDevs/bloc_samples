import 'package:utils/commands/cov/command.dart' as cov;

Future<void> main(List<String> arguments) async {
  await cov.run(arguments);
}
