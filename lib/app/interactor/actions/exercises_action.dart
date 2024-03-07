import 'package:registry_pull/app/injector.dart';
import 'package:registry_pull/app/interactor/atoms/exercise_atom.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/repositories/exercises_repository.dart';

Future<void> putExercises(ExercisesModel model) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.insertExercise(model);
  await getExercises(model.nameMuscle);
}

Future<void> getExercises(String muscle) async {
  loading.value = true;
  final repository = injector.get<ExercisesRepository>();
  exerciseState.value = await repository.getExercises(muscle);
  loading.value = false;
}

deleteExercise(String id, String muscle) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.deleteExercise(id, muscle);
  await getExercises(muscle);
}

void putDay(ExercisesModel model) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.insertDayExercise(model);
}

void removeDay(String muscle, String id, List<DayExerciseModel?> days) async {
  final repository = injector.get<ExercisesRepository>();
  await repository.deleteDayExercise(muscle, id, days);
}
