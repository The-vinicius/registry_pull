import 'package:flutter/material.dart';
import 'package:registry_pull/app/interactor/actions/exercises_action.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';
import 'package:registry_pull/l10n/app_localizations.dart';

class ContainerExpandViewModel extends ChangeNotifier {
  final ExercisesModel exercise;
  final Function(int) addserie;
  final Function(String, String, String) deleteDialog;

  int _selectedDayIndex = 0;
  int _selectedSeriesIndex = 0;

  ContainerExpandViewModel({
    required this.exercise,
    required this.addserie,
    required this.deleteDialog,
  }) {
    _initializeIndices();
  }

  int get selectedDayIndex => _selectedDayIndex;
  int get selectedSeriesIndex => _selectedSeriesIndex;

  void _initializeIndices() {
    if (exercise.days.isNotEmpty) {
      _selectedDayIndex = exercise.days.length - 1;
      _selectedSeriesIndex = 0;
    } else {
      _selectedDayIndex = 0;
      _selectedSeriesIndex = 0;
    }
    notifyListeners();
  }

  Future<bool?> showDeleteConfirmationDialog(BuildContext context, AppLocalizations loc) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${loc.remove}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(loc.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(loc.delete),
          ),
        ],
      ),
    );
  }

  void handleDaySelection(int index, bool isDay) {
    if (isDay) {
      _selectedDayIndex = index;
      _selectedSeriesIndex = 0;
    } else {
      _selectedSeriesIndex = index;
    }
    notifyListeners();
  }

  Future<void> addNewDay() async {
    final newDay = DayExerciseModel(
      id: exercise.days.isEmpty ? 0 : exercise.days.last!.id + 1,
      date: DateTime.now(),
      series: [],
    );

    exercise.days.add(newDay);
    await putDay(exercise);
    _selectedDayIndex = exercise.days.length - 1;
    _selectedSeriesIndex = 0;
    notifyListeners();
  }

  Future<void> removeLastDay() async {
    exercise.days.removeLast();
    removeDay(
      exercise.nameMuscle,
      exercise.id,
      exercise.days,
    );
    _selectedDayIndex = exercise.days.length - 1;
    _selectedSeriesIndex = 0;
    notifyListeners();
  }

  Future<void> addNewSeries() async {
    final repps = await addserie(0);
    if (repps != null) {
      final newSeries = SeriesModel(
        series: exercise.days[_selectedDayIndex]!.series.isEmpty
            ? 0
            : exercise.days[_selectedDayIndex]!.series.length,
        repetitions: repps,
      );

      exercise.days[_selectedDayIndex]!.series.add(newSeries);
      await putDay(exercise);
      _selectedSeriesIndex =
          exercise.days[_selectedDayIndex]!.series.length - 1;
      notifyListeners();
    }
  }

  Future<void> removeLastSeries() async {
    exercise.days[_selectedDayIndex]!.series.removeLast();
    removeDay(
      exercise.nameMuscle,
      exercise.id,
      exercise.days,
    );
    _selectedSeriesIndex = exercise.days[_selectedDayIndex]!.series.length - 1;
    notifyListeners();
  }

  bool get hasDays => exercise.days.isNotEmpty;
  bool get hasSeries =>
      hasDays && exercise.days[_selectedDayIndex]!.series.isNotEmpty;

  DayExerciseModel? get selectedDay =>
      hasDays ? exercise.days[_selectedDayIndex] : null;
  SeriesModel? get selectedSeries => hasSeries
      ? exercise.days[_selectedDayIndex]!.series[_selectedSeriesIndex]
      : null;
}

