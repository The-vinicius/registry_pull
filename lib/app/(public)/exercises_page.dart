import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/container_expand.dart';
import 'package:registry_pull/app/interactor/actions/exercises_action.dart';
import 'package:registry_pull/app/interactor/atoms/exercise_atom.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:routefly/routefly.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final muscle = Routefly.query.arguments;

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
                    : Column(
                        children: exercises
                            .map((exercise) => ContainerExpand(
                                  exercise: exercise,
                                  addserie: addserie,
                                  deleteDialog: deleteDialog,
                                ))
                            .toList(),
                      ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
