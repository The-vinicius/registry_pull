import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/constants/muscles.dart';
import 'package:registry_pull/routes.dart';
import 'package:routefly/routefly.dart';

class MuscleWidget extends StatelessWidget {
  final String muscle;
  final String localMuscle;
  const MuscleWidget(
      {super.key, required this.muscle, required this.localMuscle});

  @override
  Widget build(BuildContext context) {
    final path = iconM[muscle];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withAlpha(51),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        key: Key(muscle),
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
          spacing: 8,
          children: [
            Expanded(
                child:
                    Image.asset('assets/muscle/$path.png', fit: BoxFit.cover)),
            Text(
              localMuscle.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
