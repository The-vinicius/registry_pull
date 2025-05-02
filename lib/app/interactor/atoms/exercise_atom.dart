import 'package:asp/asp.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';

final exerciseState = Atom<List<ExercisesModel>>([]);
final loading = Atom<bool>(true);
