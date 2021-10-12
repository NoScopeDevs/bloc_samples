import 'package:utils/commands/rm/command.dart' as rm;

Future<void> main(List<String> arguments) async {
  await rm.run(arguments);
}
