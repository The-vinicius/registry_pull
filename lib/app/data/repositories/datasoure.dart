import 'package:localstore/localstore.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';

class Datasouce {
  final _db = Localstore.instance;

  Future<void> insertExercise(ExercisesModel model) async {
    model = model.copyWith(id: 1);

    await _db.collection(model.nameMuscle).doc().set(model.toJson());
  }

  Future<void> update(ExercisesModel model) async {
    await _db.collection(model.nameMuscle).doc().set(model.toJson());
  }

  Future<List<ExercisesModel>> getExercises(String muscle) async {
    final items = await _db.collection(muscle).get();
    items?.map((key, value) {
      (value as Map<String, dynamic>)['id'] = key.split('/')[2];
      return MapEntry(key, value);
    });
    final list = items?.values ?? [];
    return list.map((e) => ExercisesModel.fromJson(e)).toList();
  }

  Future<void> delete(String id, String muscle) async {
    await _db.collection(muscle).doc(id).delete();
  }
}
