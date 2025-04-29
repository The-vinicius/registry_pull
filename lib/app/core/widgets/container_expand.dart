import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/list_date.dart';
import 'package:registry_pull/app/core/widgets/list_series.dart';
import 'package:registry_pull/app/interactor/actions/exercises_action.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';

class ContainerExpand extends StatefulWidget {
  const ContainerExpand({
    super.key,
    required this.exercise,
    required this.addserie,
    required this.deleteDialog,
  });

  final ExercisesModel exercise;
  final Function(int) addserie;
  final Function(String, String, String) deleteDialog;

  @override
  State<ContainerExpand> createState() => _ContainerExpandState();
}

class _ContainerExpandState extends State<ContainerExpand> {
  late int _selectedDayIndex;
  late int _selectedSeriesIndex;

  @override
  void initState() {
    super.initState();
    if (widget.exercise.days.isNotEmpty) {
      // TODO: Verificar se o dia selecionado é o último
      _selectedDayIndex = widget.exercise.days.length - 1;
      _selectedSeriesIndex = 0;
    } else {
      _selectedDayIndex = 0;
      _selectedSeriesIndex = 0;
    }
  }

  Future<bool?> _showDeleteConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Deleta'),
          ),
        ],
      ),
    );
  }
  
  void _handleDaySelection(int index, bool isDay) {
    setState(() {
      if (isDay) {
        _selectedDayIndex = index;
        _selectedSeriesIndex = 0;
      } else {
        _selectedSeriesIndex = index;
      }
    });
  }

  Future<void> _addNewDay() async {
    final newDay = DayExerciseModel(
      id: widget.exercise.days.isEmpty ? 0 : widget.exercise.days.last!.id + 1,
      date: DateTime.now(),
      series: [],
    );

    widget.exercise.days.add(newDay);
    await putDay(widget.exercise);
    setState(() {
      _selectedDayIndex = widget.exercise.days.length - 1;
      _selectedSeriesIndex = 0;
    });
  }

  Future<void> _removeLastDay() async {
    final shouldDelete = await _showDeleteConfirmationDialog();
    if (shouldDelete == true) {
      widget.exercise.days.removeLast();
      removeDay(
        widget.exercise.nameMuscle,
        widget.exercise.id,
        widget.exercise.days,
      );
      setState(() {
        _selectedDayIndex = widget.exercise.days.length - 1;
        _selectedSeriesIndex = 0;
      });
    }
  }

  Future<void> _addNewSeries() async {
    final repps = await widget.addserie(0);
    if (repps != null) {
      final newSeries = SeriesModel(
        series: widget.exercise.days[_selectedDayIndex]!.series.isEmpty
            ? 0
            : widget.exercise.days[_selectedDayIndex]!.series.length,
        repetitions: repps,
      );

      widget.exercise.days[_selectedDayIndex]!.series.add(newSeries);
      await putDay(widget.exercise);
      setState(() {
        _selectedSeriesIndex =
            widget.exercise.days[_selectedDayIndex]!.series.length - 1;
      });
    }
  }

  Future<void> _removeLastSeries() async {
    final shouldDelete = await _showDeleteConfirmationDialog();
    if (shouldDelete == true) {
      widget.exercise.days[_selectedDayIndex]!.series.removeLast();
      await removeDay(
        widget.exercise.nameMuscle,
        widget.exercise.id,
        widget.exercise.days,
      );
      setState(() {
        _selectedSeriesIndex =
            widget.exercise.days[_selectedDayIndex]!.series.length - 1;
      });
    }
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Data'),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...listDate(
                  widget.exercise.days, _selectedDayIndex, _handleDaySelection),
              IconButton(
                onPressed: _addNewDay,
                icon: const Icon(Icons.add_circle_outline),
              ),
              if (widget.exercise.days.isNotEmpty)
                IconButton(
                  onPressed: _removeLastDay,
                  icon: const Icon(Icons.delete),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSeriesSection() {
    if (widget.exercise.days.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Series'),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...listSeries(
                widget.exercise.days[_selectedDayIndex]!.series,
                _selectedSeriesIndex,
                _handleDaySelection,
              ),
              IconButton(
                onPressed: _addNewSeries,
                icon: const Icon(Icons.add_circle_outlined),
              ),
              if (widget.exercise.days[_selectedDayIndex]!.series.isNotEmpty)
                IconButton(
                  onPressed: _removeLastSeries,
                  icon: const Icon(Icons.delete),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRepetitionsSection() {
    if (widget.exercise.days.isEmpty ||
        widget.exercise.days[_selectedDayIndex]!.series.isEmpty) {
      return const SizedBox.shrink();
    }

    final repetitions = widget.exercise.days[_selectedDayIndex]!
        .series[_selectedSeriesIndex].repetitions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Repetições: $repetitions'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              repetitions,
              (index) => Container(
                margin: const EdgeInsets.only(right: 5),
                height: 50,
                width: 10,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(10),
      title: GestureDetector(
        onLongPress: () => widget.deleteDialog(
          widget.exercise.id,
          widget.exercise.nameMuscle,
          widget.exercise.nameExercise,
        ),
        child: Text(widget.exercise.nameExercise),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      children: [
        const SizedBox(height: 20),
        _buildDateSection(),
        const SizedBox(height: 20),
        _buildSeriesSection(),
        const SizedBox(height: 20),
        _buildRepetitionsSection(),
      ],
    );
  }
}
