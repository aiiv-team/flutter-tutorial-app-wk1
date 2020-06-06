import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tutorial_app_wk1/src/app.dart';

Future<void> main() async {
  await DotEnv().load('.env.development');
  runApp(App());
}
