import 'package:flutter/material.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:brasil_datetime/brasil_datetime.dart' as data;

Widget listDate(DayExerciseModel? day, int index, Function(int, bool) toggle) {
  return GestureDetector(
    onTap: () {
      toggle(day.id, true);
    },
    child: Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: index == day!.id ? Colors.orange : Colors.lightBlueAccent,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: 80,
      height: 30,
      child: Center(
        child: Text(
          day.date.diaMesAbrev(),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
