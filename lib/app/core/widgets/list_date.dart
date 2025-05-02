import 'package:flutter/material.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:brasil_datetime/brasil_datetime.dart' as data;

List<Widget> listDate(
    List<DayExerciseModel?> days, int index, Function(int, bool) toggle) {
  return days
      .map(
        (e) => GestureDetector(
          onTap: () {
            toggle(e.id, true);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                color: index == e!.id ? Colors.orange : Colors.lightBlueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            width: 80,
            height: 30,
            child: Center(
              child: Text(
                e.date.diaMesAbrev(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      )
      .toList();
}
