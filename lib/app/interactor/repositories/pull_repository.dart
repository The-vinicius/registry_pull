import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';

abstract class PullRepository {
  Future<void> insertExercise(ExercisesModel model);
  Future<void> insertDay(DayExerciseModel model, int id);
  Future<void> insertSerie(SeriesModel model, int id);
  Future<List<ExercisesModel>> getExercises(String muscle);
  Future<void> deleteExercise(ExercisesModel model);
  Future<void> deleteDay(DayExerciseModel model);
  Future<void> deleteSerie(SeriesModel model);
}
