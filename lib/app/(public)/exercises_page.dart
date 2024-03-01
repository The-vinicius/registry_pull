import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/list_date.dart';
import 'package:registry_pull/app/interactor/actions/exercises_action.dart';
import 'package:registry_pull/app/interactor/atoms/exercise_atom.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:routefly/routefly.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final muscle = Routefly.query.arguments;
  final daysState = Days(0);

  @override
  void initState() {
    getExercises(muscle);
    super.initState();
  }

  void addDialog([ExercisesModel? model]) {
    model ??= ExercisesModel(
      id: 'stya',
      nameMuscle: muscle,
      nameExercise: '',
      days: [],
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Exercício'),
          content: TextFormField(
            initialValue: model?.nameExercise,
            onChanged: (value) {
              model = model!.copyWith(nameExercise: value);
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
                putExercises(model!);
                Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Routefly.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left_sharp),
        ),
        title: const Text(
          'Exercícios',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(onPressed: addDialog, icon: const Icon(Icons.add))
        ],
      ),
      body: RxBuilder(builder: (context) {
        final exercises = exerciseState.value;
        return exercises.isEmpty
            ? const Center(
                child: Text(
                  'Vá Treinar',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
            : SingleChildScrollView(
                child: loading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ExpansionPanelList(
                        expansionCallback: (index, ex) {
                          setState(() {
                            exercises[index] =
                                exercises[index].copyWith(isExpanded: ex);
                          });
                        },
                        children: exercises
                            .map(
                              (e) => ExpansionPanel(
                                headerBuilder: (context, ex) {
                                  return ListTile(
                                    title: Text(e.nameExercise),
                                  );
                                },
                                body: GestureDetector(
                                  onLongPress: () => deleteDialog(
                                      e.id, e.nameMuscle, e.nameExercise),
                                  child: ListTile(
                                    title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Data',
                                            textAlign: TextAlign.left,
                                          ),
                                          SingleChildScrollView(
                                            reverse: true,
                                            scrollDirection: Axis.horizontal,
                                            child: ValueListenableBuilder(
                                                valueListenable: daysState,
                                                builder:
                                                    (context, valor, widget) {
                                                  return Row(
                                                    children: [
                                                      ...listDate(e.days),
                                                      IconButton(
                                                          onPressed: () {
                                                            e.days.add(
                                                                DayExerciseModel(
                                                                    id: 1,
                                                                    date: DateTime
                                                                        .now(),
                                                                    series: []));
                                                            daysState
                                                                .increment();
                                                            putDay(e);
                                                          },
                                                          icon: const Icon(Icons
                                                              .add_circle_outline))
                                                    ],
                                                  );
                                                }),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'Series',
                                            textAlign: TextAlign.left,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                decoration: const BoxDecoration(
                                                    color:
                                                        Colors.lightBlueAccent,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                width: 30,
                                                height: 30,
                                                child: const Text(
                                                  '1',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text('Repetições: 5'),
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                height: 50,
                                                width: 10,
                                                color: Colors.red,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                height: 50,
                                                width: 10,
                                                color: Colors.red,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                height: 50,
                                                width: 10,
                                                color: Colors.red,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                height: 50,
                                                width: 10,
                                                color: Colors.red,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                height: 50,
                                                width: 10,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                ),
                                isExpanded: e.isExpanded,
                              ),
                            )
                            .toList()),
              );
      }),
    );
  }
}
