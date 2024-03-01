import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';

final exerciseState = Atom<List<ExercisesModel>>([]);
final loading = Atom<bool>(true);

class Days extends ValueNotifier<int> {
  Days(int value) : super(value);

  void increment() {
    notifyListeners();
  }
}
