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

  void addExercise([ExercisesModel? model]) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();

    model ??= ExercisesModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nameMuscle: muscle,
      nameExercise: '',
      days: [],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Exercício'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final updatedModel = model!.copyWith(
                    nameExercise: nameController.text,
                  );
                  await putExercises(updatedModel);
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<int?> addSerie(int initialReps) async {
    final formKey = GlobalKey<FormState>();
    final repsController = TextEditingController();

    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Total de repetições'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: repsController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                if (int.tryParse(value) == null) {
                  return 'Digite um número válido';
                }
                final reps = int.parse(value);
                if (reps <= 0) {
                  return 'Digite um número maior que zero';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final reps = int.parse(repsController.text);
                  Navigator.of(context).pop(reps);
                }
              },
              child: const Text('Salvar'),
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
            title: Text('deleta $nameExercise'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  deleteExercise(id, muscle);
                  Navigator.of(context).pop();
                },
                child: const Text('Sim'),
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
      body: AtomBuilder(builder: (context, get) {
        final exercises = get(exerciseState);
        return exercises.isEmpty
            ? const Center(
                child: Text(
                  'Vá Treinar',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
            : SingleChildScrollView(
                child: loading.state
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: exercises
                            .map((exercise) => ContainerExpand(
                                  exercise: exercise,
                                  addserie: addSerie,
                                  deleteDialog: deleteDialog,
                                ))
                            .toList(),
                      ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addExercise();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

