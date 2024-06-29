import 'package:flutter/foundation.dart';
import 'package:registry_pull/app/injector.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';
import 'package:registry_pull/app/interactor/repositories/pull_repository.dart';

class ControllerPull extends ChangeNotifier {
  bool loading = false;
  List<DayExerciseModel> days = [];
  List<SeriesModel> series = [];
  int indexSeries = 0;
  int indexRepps = 0;

  Future<void> getDays(id) async {
    loading = true;
    notifyListeners();

    final repository = injector.get<PullRepository>();
    days = await repository.getDays(id);

    loading = false;
    notifyListeners();
  }

  Future<void> putDay(int id) async {
    final model = DayExerciseModel(id: -1, date: DateTime.now());
    loading = true;

    notifyListeners();
    final repository = injector.get<PullRepository>();
    await repository.insertDay(model, id);
    days.add(model);
    loading = false;
    notifyListeners();
  }

  Future<void> deleteDay(int id) async {
    loading = true;

    notifyListeners();
    final repository = injector.get<PullRepository>();
    await repository.deleteDay(id);
    days.removeWhere((element) => element.id == id);
    loading = false;
    notifyListeners();
  }

  Future<void> putSerie(int serie, int repps, int id) async {
    final model = SeriesModel(id: -1, series: serie, repetitions: repps);
    loading = true;

    notifyListeners();
    final repository = injector.get<PullRepository>();
    await repository.insertSerie(model, id);
    series.add(model);
    loading = false;
    notifyListeners();
  }

  Future<void> getSeries(int id) async {
    loading = true;

    notifyListeners();
    final repository = injector.get<PullRepository>();
    series = await repository.getSeries(id);
    loading = false;
    notifyListeners();
  }

  Future<void> deleteSerie(int id) async {
    loading = true;

    notifyListeners();
    final repository = injector.get<PullRepository>();
    await repository.deleteSerie(id);
    series.removeWhere((element) => element.id == id);
    loading = false;
    notifyListeners();
  }

  Future<void> putExercise(ExercisesModel model) async {
    loading = true;
    notifyListeners();
    final repository = injector.get<PullRepository>();
    await repository.insertExercise(model);
  }
}
