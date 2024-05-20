import 'package:auto_injector/auto_injector.dart';
import 'package:registry_pull/app/data/repositories/datasoure.dart';
import 'package:registry_pull/app/data/repositories/localstore_exercises_repository.dart';
import 'package:registry_pull/app/interactor/repositories/exercises_repository.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.add<Datasouce>(Datasouce.new);
  injector.add<ExercisesRepository>(LocalstoreExercisesRepository.new);
  injector.commit();
}
