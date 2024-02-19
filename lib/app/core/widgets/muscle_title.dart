import 'package:flutter/material.dart';
import 'package:registry_pull/routes.dart';
import 'package:routefly/routefly.dart';

class MuscleTitle extends StatelessWidget {
  const MuscleTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      decoration: const BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        onTap: () {
          Routefly.pushNavigate(routePaths.exercises);
        },
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.blue,
        ),
      ),
    );
  }
}
