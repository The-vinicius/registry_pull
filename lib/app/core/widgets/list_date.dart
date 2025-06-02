import 'package:brasil_datetime/brasil_datetime.dart';
import 'package:flutter/material.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
// import 'package:brasil_datetime/brasil_datetime.dart' as data;
// import 'package:timeago/timeago.dart' as timeago;

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
                color: index == e!.id
                    ? const Color.fromRGBO(190, 145, 239, .86)
                    : Colors.white10,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12, width: 1.0)),
            width: 120,
            height: 40,
            child: Center(
              child: Text(
                "${e.date.day} ${e.date.mes()} ${e.date.year}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: index == e.id ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      )
      .toList();
}

String timeAgo(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays == 0) {
    return 'hoje';
  }

  if (difference.inDays < 7) {
    final days = difference.inDays;
    return days == 1 ? 'há 1 dia' : 'há $days dias';
  }

  if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return weeks == 1 ? 'há 1 semana' : 'há $weeks semanas';
  }

  // Calculate months difference
  var months = (now.year - date.year) * 12 + now.month - date.month;
  if (now.day < date.day) {
    months -= 1;
  }
  if (months < 12) {
    return months == 1 ? 'há 1 mês' : 'há $months meses';
  }

  final years = now.year -
      date.year -
      ((now.month < date.month ||
              (now.month == date.month && now.day < date.day))
          ? 1
          : 0);
  return years == 1 ? 'há 1 ano' : 'há $years anos';
}
