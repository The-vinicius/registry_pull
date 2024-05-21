import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/container_expand.dart';
import 'package:registry_pull/app/interactor/actions/pull_action.dart';
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
      id: -1,
      nameMuscle: muscle,
      nameExercise: '',
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          key: const Key('alerte'),
          title: const Text('Adicionar Exercício'),
          content: TextFormField(
            key: const Key('name_key'),
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
              key: const Key('save_key'),
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
          IconButton(
              key: const Key('add'),
              onPressed: addDialog,
              icon: const Icon(Icons.add))
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
                key: const Key('certo'),
                child: loading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: exercises
                            .map((exercise) => ContainerExpand(
                                  exercise: exercise,
                                ))
                            .toList(),
                      ),
              );
      }),
    );
  }
}
