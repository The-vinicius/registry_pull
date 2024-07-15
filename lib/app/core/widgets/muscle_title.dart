import 'package:flutter/material.dart';
import 'package:registry_pull/routes.dart';
import 'package:routefly/routefly.dart';

class MuscleTitle extends StatelessWidget {
  const MuscleTitle({required super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      decoration: const BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        onTap: () {
          Routefly.pushNavigate(routePaths.exercises, arguments: title);
        },
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
