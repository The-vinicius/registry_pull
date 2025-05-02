import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registry_pull/app/states/container_expand_viewmodel.dart';
import 'package:registry_pull/app/core/widgets/list_date.dart';
import 'package:registry_pull/app/core/widgets/list_series.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';

class ContainerExpand extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContainerExpandViewModel(
        exercise: exercise,
        addserie: addserie,
        deleteDialog: deleteDialog,
      ),
      child: const _ContainerExpandContent(),
    );
  }
}

class _ContainerExpandContent extends StatelessWidget {
  const _ContainerExpandContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ContainerExpandViewModel>();

    return ExpansionTile(
      leading: IconButton(
          onPressed: () => viewModel.deleteDialog(
                viewModel.exercise.id,
                viewModel.exercise.nameMuscle,
                viewModel.exercise.nameExercise,
              ),
          icon: const Icon(Icons.delete)),
      childrenPadding: const EdgeInsets.all(10),
      title: Text(viewModel.exercise.nameExercise),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      children: [
        const SizedBox(height: 20),
        _buildDateSection(context),
        const SizedBox(height: 20),
        _buildSeriesSection(context),
        const SizedBox(height: 20),
        _buildRepetitionsSection(context),
      ],
    );
  }

  Widget _buildDateSection(BuildContext context) {
    final viewModel = context.watch<ContainerExpandViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Dias',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...listDate(
                viewModel.exercise.days,
                viewModel.selectedDayIndex,
                viewModel.handleDaySelection,
              ),
              IconButton(
                onPressed: viewModel.addNewDay,
                icon: const Icon(Icons.add_circle_outline),
              ),
              if (viewModel.hasDays)
                IconButton(
                  onPressed: () async {
                    final shouldDelete =
                        await viewModel.showDeleteConfirmationDialog(context);
                    if (shouldDelete == true) {
                      await viewModel.removeLastDay();
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSeriesSection(BuildContext context) {
    final viewModel = context.watch<ContainerExpandViewModel>();
    if (!viewModel.hasDays) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Series',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...listSeries(
                viewModel.exercise.days[viewModel.selectedDayIndex]!.series,
                viewModel.selectedSeriesIndex,
                viewModel.handleDaySelection,
              ),
              IconButton(
                onPressed: viewModel.addNewSeries,
                icon: const Icon(Icons.add_circle_outlined),
              ),
              if (viewModel.hasSeries)
                IconButton(
                  onPressed: () async {
                    final shouldDelete =
                        await viewModel.showDeleteConfirmationDialog(context);
                    if (shouldDelete == true) {
                      await viewModel.removeLastSeries();
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRepetitionsSection(BuildContext context) {
    final viewModel = context.watch<ContainerExpandViewModel>();
    if (!viewModel.hasSeries) return const SizedBox.shrink();

    final repetitions = viewModel.selectedSeries?.repetitions ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
          text: 'Repetições: ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: '$repetitions',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        )),
      ],
    );
  }
}