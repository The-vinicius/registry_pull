import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/list_date.dart';
import 'package:registry_pull/app/core/widgets/list_series.dart';
import 'package:registry_pull/app/interactor/actions/pull_action.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/states/controller_pull.dart';
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
  final controller = ControllerPull();

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
    controller.getDays(widget.exercise.id);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    final indexSeries = controller.days.last.id;

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
        children: [
          if (!controller.loading)
            SizedBox(
              height: 70,
              child: SuperListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.days.length,
                  itemBuilder: (cxt, index) {
                    return listDate(
                        controller.days[index], indexSeries, toggleVibration);
                  }),
            ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    controller.putDay(exercise.id);
                  },
                  icon: const Icon(Icons.add)),
              if (controller.days.isNotEmpty)
                IconButton(
                    onPressed: () {
                      controller.deleteDay(controller.days.last.id);
                    },
                    icon: const Icon(Icons.delete))
            ],
          ),
          if (controller.days.isNotEmpty)
            Row(
              children: [
                ...listSeries(controller.series, indexRepps, toggleVibration),
              ],
            )
        ]);
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
