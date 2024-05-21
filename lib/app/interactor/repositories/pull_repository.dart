import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';

abstract class PullRepository {
  Future<void> insertExercise(ExercisesModel model);
  Future<void> insertDay(DayExerciseModel model, int id);
  Future<void> insertSerie(SeriesModel model, int id);
  Future<List<ExercisesModel>> getExercises(String muscle);
  Future<List<DayExerciseModel>> getDays(int id);
  Future<List<SeriesModel>> getSeries(int id);
  Future<void> deleteExercise(int id);
  Future<void> deleteDay(int id);
  Future<void> deleteSerie(int id);
}
