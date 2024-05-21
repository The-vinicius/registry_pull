import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:registry_pull/app/core/widgets/list_date.dart';
import 'package:registry_pull/app/core/widgets/list_series.dart';
import 'package:registry_pull/app/interactor/actions/pull_action.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;

    return FutureBuilder(
        future: getDays(exercise.id),
        builder: (context, snapshot) {
          return ExpansionTile(
              key: const Key('expansion'),
              childrenPadding: const EdgeInsets.all(10),
              title: GestureDetector(
                onLongPress: () => deleteDialog(
                    exercise.id, exercise.nameMuscle, exercise.nameExercise),
                child: Text(exercise.nameExercise),
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              children: []);
        });
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

  void deleteDialog(int id, String muscle, String nameExercise) {
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
