import 'package:asp/asp.dart';
import 'package:registry_pull/app/interactor/atoms/exercise_atom.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';

final changeExerciseState = atomAction1<List<ExercisesModel>>((set, newEx) {
  set(exerciseState, newEx);
});

final changeLoading = atomAction1<bool>((set, newLoad) {
  set(loading, newLoad);
});
