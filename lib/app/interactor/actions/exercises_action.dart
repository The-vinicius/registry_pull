import 'package:registry_pull/app/injector.dart';
import 'package:registry_pull/app/interactor/atoms/actions.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/repositories/exercises_repository.dart';

Future<void> putExercises(ExercisesModel model) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.insertExercise(model);
  await getExercises(model.nameMuscle);
}

Future<void> getExercises(String muscle) async {
  changeLoading(true);
  final repository = injector.get<ExercisesRepository>();
  final exercise = await repository.getExercises(muscle);
  changeExerciseState(exercise);
  changeLoading(false);
}

deleteExercise(String id, String muscle) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.deleteExercise(id, muscle);
  await getExercises(muscle);
}

void putDay(ExercisesModel model) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.updateExercise(model);
}

void removeDay(ExercisesModel model) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.updateExercise(model);
}
