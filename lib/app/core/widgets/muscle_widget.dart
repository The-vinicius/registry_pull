import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/constants/muscles.dart';
import 'package:registry_pull/routes.dart';
import 'package:routefly/routefly.dart';

class MuscleWidget extends StatelessWidget {
  final String muscle;
  const MuscleWidget({super.key, required this.muscle});

  @override
  Widget build(BuildContext context) {
    final path = iconM[muscle];
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 5,
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
        child: Column(
          children: [
            SizedBox(
                width: 50,
                height: 70,
                child: Image.asset('assets/muscle/$path.png')),
            const Spacer(),
            Text(
              muscle.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
