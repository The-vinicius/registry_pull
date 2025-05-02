import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/repositories/exercises_repository.dart';
import 'package:localstore/localstore.dart';

class LocalstoreExercisesRepository implements ExercisesRepository {
  final db = Localstore.instance;

  @override
  Future<bool> deleteDayExercise(
      String nameMuscle, String id, List<DayExerciseModel?> days) async {
    final map = days.map((e) => e?.toJson()).toList();
    db
        .collection(nameMuscle)
        .doc(id)
        .set({'days': map}, SetOptions(merge: true));
    return true;
  }

  @override
  Future<bool> deleteExercise(String id, String muscle) async {
    await db.collection(muscle).doc(id).delete();
    return true;
  }

  @override
  Future<List<ExercisesModel>> getExercises(String muscle) async {
    final items = await db.collection(muscle).get();
    items?.map((key, value) {
      (value as Map<String, dynamic>)['id'] = key.split('/')[2];
      return MapEntry(key, value);
    });
    final list = items?.values ?? [];
    return list.map((e) => ExercisesModel.fromJson(e)).toList();
  }

  @override
  Future<DayExerciseModel> insertDayExercise(ExercisesModel model) async {
    await db.collection(model.nameMuscle).doc(model.id).set(model.toJson());
    return model.days.last!;
  }

  @override
  Future<ExercisesModel> insertExercise(ExercisesModel model) async {
    model = model.copyWith(id: '');

    await db.collection(model.nameMuscle).doc().set(model.toJson());
    return model;
  }
}
