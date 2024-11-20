import 'package:flutter/material.dart';
import 'package:registry_pull/routes.dart';
import 'package:routefly/routefly.dart';

class MuscleWidget extends StatelessWidget {
  final String muscle;
  const MuscleWidget({super.key, required this.muscle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.transparent, Color.fromARGB(255, 0, 0, 0) ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          Routefly.pushNavigate(routePaths.exercises, arguments: muscle);
        },
        child: Text(
          muscle.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(0, 2),
                blurRadius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
