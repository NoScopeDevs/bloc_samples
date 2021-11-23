import 'package:flutter/material.dart';
import 'package:launch_analytics/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bootstrap();
}
