import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/list_date.dart';
import 'package:registry_pull/app/core/widgets/list_series.dart';
import 'package:registry_pull/app/interactor/actions/pull_action.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/states/controller_pull.dart';

class ShowPulls extends StatefulWidget {
  const ShowPulls({super.key, required this.exercise});
  final ExercisesModel exercise;

  @override
  State<ShowPulls> createState() => _ShowPullsState();
}

class _ShowPullsState extends State<ShowPulls> {
  final controllerPull = ControllerPull();

  @override
  void initState() {
    super.initState();
    controllerPull.getDays(widget.exercise.id);
    controllerPull.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controllerPull.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    return ExpansionTile(
      title: GestureDetector(
          onLongPress: () => deleteDialog(
              exercise.id, exercise.nameMuscle, exercise.nameExercise),
          child: Text(exercise.nameExercise)),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!controllerPull.loading) ...[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text(
                  'Dias: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                IconButton(
                    onPressed: () async {
                      await controllerPull.putDay(widget.exercise.id);
                    },
                    icon: const Icon(Icons.add_sharp)),
                if (controllerPull.days.isNotEmpty)
                  IconButton(
                      onPressed: () async {
                        await controllerPull.deleteDay();
                      },
                      icon: const Icon(Icons.delete)),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
                children: controllerPull.days.asMap().entries.map((entry) {
              int indexId = entry.key;
              return listDate(entry.value, controllerPull.indexSeries,
                  controllerPull.toggleVibration, indexId);
            }).toList()),
          ),
          if (controllerPull.days.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Series: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Row(children: [
              ...listSeries(controllerPull.series, controllerPull.indexRepps,
                  controllerPull.toggleVibration),
              IconButton(
                  onPressed: () async {
                    final repps = await addserie();
                    if (repps != null) {
                      await controllerPull.putSerie(
                        repps,
                      );
                    }
                  },
                  icon: const Icon(Icons.add)),
              if (controllerPull.series.isNotEmpty)
                IconButton(
                    onPressed: () async {
                      await controllerPull.deleteSerie();
                    },
                    icon: const Icon(Icons.delete)),
            ])
          ],
          if (controllerPull.series.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Repetições: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: List.generate(
                  controllerPull.repps,
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
        ] else if (controllerPull.loading)
          const CircularProgressIndicator()
      ],
    );
  }

  Future<int?> addserie() async {
    return showDialog<int>(
      context: context,
      builder: (context) {
        int repps = 0;
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
      },
    );
  }
}
