import 'package:registry_pull/app/interactor/models/exercises_model.dart';

abstract class ExercisesRepository {
  Future<List<ExercisesModel>> getExercises(String muscle);
  Future<ExercisesModel> insertExercise(ExercisesModel model);
  Future<ExercisesModel> updateExercise(ExercisesModel model);
  Future<bool> deleteExercise(String id, String muscle);
}
