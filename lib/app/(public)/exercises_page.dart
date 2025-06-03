import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/container_expand.dart';
import 'package:registry_pull/app/interactor/actions/exercises_action.dart';
import 'package:registry_pull/app/interactor/atoms/exercise_atom.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/l10n/app_localizations.dart';
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
    final loc = AppLocalizations.of(context)!;

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
          title: Text(loc.addExercise),
          content: Form(
            key: formKey,
            child: TextFormField(
              key: const Key('name_key'),
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.requiredField;
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
              child: Text(loc.cancel),
            ),
            TextButton(
              key: const Key('save_key'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final updatedModel = model!.copyWith(
                    nameExercise: nameController.text,
                  );
                  await putExercises(updatedModel);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: Text(loc.save),
            ),
          ],
        );
      },
    );
  }

  Future<int?> addSerie(int initialReps) async {
    final formKey = GlobalKey<FormState>();
    final repsController = TextEditingController();
    final loc = AppLocalizations.of(context)!;

    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(loc.totalRep),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: repsController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.requiredField;
                }
                if (int.tryParse(value) == null) {
                  return loc.invalidNumber;
                }
                final reps = int.parse(value);
                if (reps <= 0) {
                  return loc.gtZero;
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
              child: Text(loc.cancel),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final reps = int.parse(repsController.text);
                  Navigator.of(context).pop(reps);
                }
              },
              child: Text(loc.save),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> deleteDialog(
      String id, String muscle, String nameExercise) async {
    final loc = AppLocalizations.of(context)!;
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('${loc.delete} $nameExercise'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(loc.no),
              ),
              TextButton(
                onPressed: () {
                  deleteExercise(id, muscle);
                  Navigator.of(context).pop(true);
                },
                child: Text(loc.yes),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Routefly.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left_sharp),
        ),
        title: Text(
          loc.exercises,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: AtomBuilder(builder: (context, get) {
        final exercises = get(exerciseState);
        return exercises.isEmpty
            ? Center(
                child: Text(
                  loc.goTrain,
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
                            .map((exercise) => Dismissible(
                                  key: Key(exercise.id),
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.delete,
                                        color: Colors.white, size: 30),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  dismissThresholds: const {
                                    DismissDirection.endToStart: 0.5,
                                  },
                                  confirmDismiss: (direction) async {
                                    var confirm = await deleteDialog(
                                        exercise.id,
                                        exercise.nameMuscle,
                                        exercise.nameExercise);
                                    return confirm;
                                  },
                                  child: ContainerExpand(
                                    exercise: exercise,
                                    addserie: addSerie,
                                    deleteDialog: deleteDialog,
                                  ),
                                ))
                            .toList(),
                      ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        key: const Key('add'),
        onPressed: () {
          addExercise();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
