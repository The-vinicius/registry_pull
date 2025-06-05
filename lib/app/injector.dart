import 'package:auto_injector/auto_injector.dart';
import 'package:registry_pull/app/data/repositories/local_last_muscle_repository.dart';
import 'package:registry_pull/app/data/repositories/localstore_exercises_repository.dart';
import 'package:registry_pull/app/interactor/repositories/exercises_repository.dart';
import 'package:registry_pull/app/interactor/repositories/last_mucle_repository.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.add<ExercisesRepository>(LocalstoreExercisesRepository.new);
  injector.add<LastMuscleRepository>(LocalLastMuscleRepository.new);
  injector.commit();
}
