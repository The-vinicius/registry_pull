import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/list_date.dart';
import 'package:registry_pull/app/core/widgets/list_series.dart';
import 'package:registry_pull/app/interactor/actions/exercises_action.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class ContainerExpand extends StatefulWidget {
  const ContainerExpand({
    super.key,
    required this.exercise,
  });
  final ExercisesModel exercise;

  @override
  State<ContainerExpand> createState() => _ContainerExpandState();
}

class _ContainerExpandState extends State<ContainerExpand> {
  var indexSeries = 0;
  var indexRepps = 0;

  final _listController = ListController();
  final ScrollController _scrollController = ScrollController();

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

  void jumpToItem(int index) {
    _listController.jumpToItem(
      index: index,
      scrollController: _scrollController,
      alignment: 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;

    return ExpansionTile(
      key: const Key('expansion'),
      onExpansionChanged: (_) {
        Future.delayed(const Duration(milliseconds: 200), () {
          jumpToItem(exercise.days.length);
        });
      },
      childrenPadding: const EdgeInsets.all(10),
      title: GestureDetector(
        onLongPress: () => deleteDialog(
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
        SizedBox(
          width: double.infinity,
          height: 40,
          child: SuperListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              listController: _listController,
              itemCount: exercise.days.length + 1,
              itemBuilder: (_, index) {
                if (exercise.days.length - index - 1 < 0) {
                  return IconButton(
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
                      icon: const Icon(Icons.add_circle_outline));
                }

                final ex = exercise.days[index];
                return listDate(ex, indexSeries, toggleVibration);
              }),
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
                      final repps = await addserie(0);
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
                          removeDay(exercise);
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

  Future<int?> addserie(int repps) async {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Total de repetições'),
          content: TextFormField(
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              repps = int.parse(value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(repps);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteDialog(String id, String muscle, String nameExercise) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('delete $nameExercise'),
            actions: [
              TextButton(
                onPressed: () {
                  deleteExercise(id, muscle);
                  Navigator.of(context).pop();
                },
                child: const Text('Sim'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Não'),
              )
            ],
          );
        });
  }
}
