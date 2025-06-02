import 'package:flutter_test/flutter_test.dart';
import 'package:registry_pull/app/data/repositories/localstore_exercises_repository.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';

void main() {
  late LocalstoreExercisesRepository repository;

  setUp(() {
    repository = LocalstoreExercisesRepository();
  });

  group('Local store |', () {
    test('add and delete exercise', () async {
      final exercise = ExercisesModel(
        id: '',
        nameMuscle: 'Braços',
        nameExercise: 'paralelas',
        days: const [],
      );

      final newExer = await repository.insertExercise(exercise);
      expect(newExer.nameExercise, equals(exercise.nameExercise));
      final isTrue = await repository.deleteExercise(newExer.id, newExer.nameMuscle);
      expect(isTrue, true);
      });  
  });
}
