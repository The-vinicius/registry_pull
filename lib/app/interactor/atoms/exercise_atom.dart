import 'package:asp/asp.dart';
import 'package:flutter/cupertino.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';

final exerciseState = atom<List<ExercisesModel>>([]);
final loading = atom<bool>(true);
final selectedMuscle = ValueNotifier<String>("");
