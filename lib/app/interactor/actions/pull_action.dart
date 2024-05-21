import 'package:registry_pull/app/injector.dart';
import 'package:registry_pull/app/interactor/atoms/exercise_atom.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';
import 'package:registry_pull/app/interactor/repositories/pull_repository.dart';

Future<void> putExercises(ExercisesModel model) async {
  final repository = injector.get<PullRepository>();
  await repository.insertExercise(model);
  await getExercises(model.nameMuscle);
}

void putDay(DayExerciseModel model, int id) async {
  final repository = injector.get<PullRepository>();
  await repository.insertDay(model, id);
}

void putSerie(SeriesModel model, int id) async {
  final repository = injector.get<PullRepository>();
  await repository.insertSerie(model, id);
}

Future<void> getExercises(String muscle) async {
  loading.value = true;
  final repository = injector.get<PullRepository>();
  exerciseState.value = await repository.getExercises(muscle);
  loading.value = false;
}

Future<List<DayExerciseModel>> getDays(int id) async {
  final repository = injector.get<PullRepository>();
  return await repository.getDays(id);
}

Future<List<SeriesModel>> getSeries(int id) async {
  final repository = injector.get<PullRepository>();
  return await repository.getSeries(id);
}

deleteExercise(int id, String muscle) async {
  final repository = injector.get<PullRepository>();
  await repository.deleteExercise(id);
  await getExercises(muscle);
}

deleteDay(int id, String muscle) async {
  final repository = injector.get<PullRepository>();
  await repository.deleteDay(id);
  await getExercises(muscle);
}

deleteSerie(int id, String muscle) async {
  final repository = injector.get<PullRepository>();
  await repository.deleteSerie(id);
  await getExercises(muscle);
}
