import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/list_date.dart';
import 'package:registry_pull/app/core/widgets/list_series.dart';
import 'package:registry_pull/app/interactor/actions/exercises_action.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';

class ContainerExpand extends StatefulWidget {
  const ContainerExpand({
    super.key,
    required this.exercise,
    required this.addserie,
    required this.deleteDialog,
  });
  final ExercisesModel exercise;
  final Function(int) addserie;
  final Function(String, String, String) deleteDialog;

  @override
  State<ContainerExpand> createState() => _ContainerExpandState();
}

class _ContainerExpandState extends State<ContainerExpand> {
  var indexSeries = 0;
  var indexRepps = 0;

  Future<bool?> deleteDay() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remover?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Deleta'),
            ),
          ],
        );
      },
    );
  }

  void toggleVibration(int index, bool serie) {
    setState(() {
      if (serie) {
        indexSeries = index;
        indexRepps = 0;
      } else {
        indexRepps = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;

    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(10),
      title: GestureDetector(
        onLongPress: () => widget.deleteDialog(
            exercise.id, exercise.nameMuscle, exercise.nameExercise),
        child: Text(exercise.nameExercise),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text('Data'),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...listDate(exercise.days, indexSeries, toggleVibration),
              IconButton(
                  onPressed: () {
                    exercise.days.add(DayExerciseModel(
                        id: exercise.days.isEmpty
                            ? 0
                            : exercise.days.last!.id + 1,
                        date: DateTime.now(),
                        series: []));
                    putDay(exercise);
                    setState(() {});
                  },
                  icon: const Icon(Icons.add_circle_outline)),
              if (exercise.days.isNotEmpty)
                IconButton(
                    onPressed: () async {
                      final del = await deleteDay();
                      if (del == true) {
                        exercise.days.removeLast();
                        removeDay(
                            exercise.nameMuscle, exercise.id, exercise.days);
                        setState(() {
                          indexSeries = 0;
                          indexRepps = 0;
                        });
                      }
                    },
                    icon: const Icon(Icons.delete)),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (exercise.days.isNotEmpty) ...[
          const Text('Series'),
          SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...listSeries(exercise.days[indexSeries]!.series, indexRepps,
                    toggleVibration),
                IconButton(
                    onPressed: () async {
                      final repps = await widget.addserie(0);
                      if (repps != null) {
                        exercise.days[indexSeries]!.series.add(SeriesModel(
                            series: exercise.days[indexSeries]!.series.isEmpty
                                ? 0
                                : exercise.days[indexSeries]!.series.length,
                            repetitions: repps));
                        putDay(exercise);
                      }
                      setState(() {});
                    },
                    icon: const Icon(Icons.add_circle_outlined)),
                if (exercise.days[indexSeries]!.series.isNotEmpty)
                  IconButton(
                      onPressed: () async {
                        final del = await deleteDay();
                        if (del == true) {
                          exercise.days[indexSeries]!.series.removeLast();
                          removeDay(
                              exercise.nameMuscle, exercise.id, exercise.days);
                          setState(() {
                            indexSeries = 0;
                            indexRepps = 0;
                          });
                        }
                      },
                      icon: const Icon(Icons.delete)),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (exercise.days[indexSeries]!.series.isNotEmpty) ...[
            Text(
                'Repetições: ${exercise.days[indexSeries]!.series[indexRepps].repetitions}'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  exercise.days[indexSeries]!.series[indexRepps].repetitions,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 50,
                    width: 10,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ]
        ],
      ],
    );
  }
}
