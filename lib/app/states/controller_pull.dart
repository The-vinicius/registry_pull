import 'package:flutter/foundation.dart';
import 'package:registry_pull/app/injector.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';
import 'package:registry_pull/app/interactor/repositories/pull_repository.dart';

class ControllerPull extends ChangeNotifier {
  bool loading = false;
  List<DayExerciseModel> days = [];
  List<SeriesModel> series = [];
  int indexSeries = 0;
  int indexRepps = 0;
  int repps = 0;

  Future<void> getDays(id) async {
    loading = true;
    notifyListeners();

    final repository = injector.get<PullRepository>();
    days = await repository.getDays(id);
    indexSeries = days.length - 1;
    if (days.isNotEmpty) {
      await getSeries(days.last.id);
    }

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
    await getDays(id);
    loading = false;
    notifyListeners();
  }

  Future<void> deleteDay() async {
    final id = days.last.id;
    loading = true;

    notifyListeners();
    final repository = injector.get<PullRepository>();
    await repository.deleteDay(id);
    days.removeLast();
    series.clear();
    indexSeries = days.length - 1;
    loading = false;
    notifyListeners();
  }

  Future<void> putSerie(int repps) async {
    final id = days[indexSeries].id;
    final serie = series.length;
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
    series.clear();
    series = await repository.getSeries(id);
    if (series.isNotEmpty) {
      repps = series.first.repetitions;
    }
    loading = false;
    notifyListeners();
  }

  Future<void> deleteSerie() async {
    loading = true;
    final id = series.last.id;

    notifyListeners();
    final repository = injector.get<PullRepository>();
    await repository.deleteSerie(id);
    series.removeLast();
    loading = false;
    notifyListeners();
  }

  void toggleVibration(int index, bool serie) async {
    loading = true;
    notifyListeners();
    if (serie) {
      indexSeries = index;
      indexRepps = 0;
      await getSeries(days[indexSeries].id);
    } else {
      indexRepps = index;
      repps = series[indexRepps].repetitions;
    }
    loading = false;
    notifyListeners();
  }
}
