import 'package:flutter/material.dart';
import 'package:registry_pull/app/interactor/actions/exercises_action.dart';
import 'package:registry_pull/routes.dart';
import 'package:routefly/routefly.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLastMuscle();
      Routefly.navigate(routePaths.home);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
