import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';

abstract class ExercisesRepository {
  Future<List<ExercisesModel>> getExercises(String muscle);
  Future<ExercisesModel> insertExercise(ExercisesModel model);
  Future<DayExerciseModel> insertDayExercise(ExercisesModel model);
  Future<bool> deleteExercise(String id, String muscle);
  Future<bool> deleteDayExercise(
      String muscle, String id, List<DayExerciseModel?> days);
}