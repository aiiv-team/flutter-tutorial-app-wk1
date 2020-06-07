import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentProvider extends InheritedWidget {
  final String stage;
  final String appName;

  EnvironmentProvider(
      {@required this.stage, @required this.appName, @required Widget child})
      : super(child: child);

  static EnvironmentProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<EnvironmentProvider>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static EnvironmentProvider fromDotEnv(Widget child) {
    final env = DotEnv().env;
    return EnvironmentProvider(
        stage: env['STAGE'], appName: env['APP_NAME'], child: child);
  }
}
