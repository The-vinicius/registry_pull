import 'package:flutter/material.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';

List<Widget> listDate(List<DayExerciseModel?> days) {
  return days
      .map(
        (e) => Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(right: 5),
          decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: 60,
          height: 30,
          child: Text(
            '${e?.date.day}/${e?.date.month}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      )
      .toList();
}
