import 'package:registry_pull/app/injector.dart';
import 'package:registry_pull/app/interactor/atoms/actions.dart';
import 'package:registry_pull/app/interactor/atoms/exercise_atom.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/repositories/exercises_repository.dart';
import 'package:registry_pull/app/interactor/repositories/last_mucle_repository.dart';

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

Future<void> deleteExercise(String id, String muscle) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.deleteExercise(id, muscle);
  await getExercises(muscle);
}

Future<void> putDay(ExercisesModel model) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.insertDayExercise(model);
}

Future<void> removeDay(
    String muscle, String id, List<DayExerciseModel?> days) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.deleteDayExercise(muscle, id, days);
}

Future<void> saveLastMuscle(String muscle) async {
  final repository = injector.get<LastMuscleRepository>();
  await repository.saveLastMuscle(muscle);
  selectedMuscle.value = muscle;
}

Future<void> getLastMuscle() async {
  final repository = injector.get<LastMuscleRepository>();
  selectedMuscle.value = await repository.getLastMuscle() ?? "";
}
