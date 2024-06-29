import 'package:flutter/material.dart';
import 'package:registry_pull/app/states/controller_pull.dart';

class ShowPulls extends StatelessWidget {
  const ShowPulls({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerPull = ControllerPull();
    return ListenableBuilder(
        listenable: controllerPull,
        builder: (cxt, widget) {
          return Container();
        });
  }
}
