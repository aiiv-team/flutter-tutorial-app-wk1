import 'package:flutter/material.dart';

class EnvironmentProvider extends InheritedWidget {
  final String appName;

  EnvironmentProvider({@required this.appName});

  static EnvironmentProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<EnvironmentProvider>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
