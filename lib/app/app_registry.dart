import 'package:flutter/material.dart';
import 'package:registry_pull/routes.dart';
import 'package:routefly/routefly.dart';

class AppRegistry extends StatelessWidget {
  const AppRegistry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Registry pull',
      routerConfig:
          Routefly.routerConfig(routes: routes, initialPath: routePaths.splash),
    );
  }
}
