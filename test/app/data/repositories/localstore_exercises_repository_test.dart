import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:registry_pull/app/data/repositories/datasoure.dart';
import 'package:registry_pull/app/data/repositories/localstore_exercises_repository.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';

class DatasouceMock extends Mock implements Datasouce {}

void main() {
  final datasouce = DatasouceMock();
  late LocalstoreExercisesRepository repository;

  setUp(() {
    repository = LocalstoreExercisesRepository(datasouce);
  });

  group('Local store |', () {
    test('insert exercise', () async {
      final exercise = ExercisesModel(
        id: '',
        nameMuscle: 'braços',
        nameExercise: 'paralelas',
        days: const [],
      );

      when(() => datasouce.insertExercise(exercise)).thenAnswer((_) async {});

      final newExer = await repository.insertExercise(exercise);
      expect(newExer, equals(exercise));
    });

    test('update exercise', () async {
      final exercise = ExercisesModel(
        id: '',
        nameMuscle: 'braços',
        nameExercise: 'paralelas',
        days: const [],
      );

      when(() => datasouce.update(exercise)).thenAnswer((_) async {});

      final newExer = await repository.updateExercise(exercise);
      expect(newExer, equals(exercise));
    });

    test('get exercises', () async {
      final exercise = ExercisesModel(
        id: '',
        nameMuscle: 'braços',
        nameExercise: 'paralelas',
        days: const [],
      );

      when(() => datasouce.getExercises(any()))
          .thenAnswer((_) async => [exercise]);

      final exercises = await repository.getExercises('broços');
      expect(exercises.length, 1);
    });

    test('delete exercise', () async {
      when(() => datasouce.delete(any(), any())).thenAnswer((_) async => []);

      final isTrue = await repository.deleteExercise('1', 'broços');
      expect(isTrue, true);
    });
  });
}
