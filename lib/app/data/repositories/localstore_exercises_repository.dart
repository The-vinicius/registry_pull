import 'package:registry_pull/app/data/repositories/datasoure.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/repositories/exercises_repository.dart';

class LocalstoreExercisesRepository implements ExercisesRepository {
  final Datasouce _datasouce;
  LocalstoreExercisesRepository(Datasouce datasouce) : _datasouce = datasouce;

  @override
  Future<bool> deleteExercise(String id, String muscle) async {
    await _datasouce.delete(id, muscle);
    return true;
  }

  @override
  Future<List<ExercisesModel>> getExercises(String muscle) async {
    final exercises = await _datasouce.getExercises(muscle);
    return exercises;
  }

  @override
  Future<ExercisesModel> updateExercise(ExercisesModel model) async {
    await _datasouce.update(model);
    return model;
  }

  @override
  Future<ExercisesModel> insertExercise(ExercisesModel model) async {
    await _datasouce.insertExercise(model);
    return model;
  }
}
