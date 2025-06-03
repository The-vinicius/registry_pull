import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registry_pull/app/states/container_expand_viewmodel.dart';
import 'package:registry_pull/app/core/widgets/list_date.dart';
import 'package:registry_pull/app/core/widgets/list_series.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/core/widgets/card_expansion.dart';
import 'package:registry_pull/l10n/app_localizations.dart';

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
    final loc = AppLocalizations.of(context)!;
    final viewModel = context.watch<ContainerExpandViewModel>();
    return CardExpansion(
      margin: const EdgeInsets.all(3),
      key: const Key('expansion'),
      title: Text(viewModel.exercise.nameExercise),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSection(context, loc),
            const SizedBox(height: 20),
            _buildSeriesSection(context, loc),
            const SizedBox(height: 20),
            _buildRepetitionsSection(context, loc),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection(BuildContext context, AppLocalizations loc) {
    final viewModel = context.watch<ContainerExpandViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(loc.days,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 4,
            children: [
              ...listDate(
                viewModel.exercise.days,
                viewModel.selectedDayIndex,
                viewModel.handleDaySelection,
              ),
            ],
          ),
        ),
        Row(
          spacing: 4,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side:
                    const BorderSide(color: Color.fromRGBO(196, 142, 239, .86)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed: viewModel.addNewDay,
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: '+', style: TextStyle(color: Colors.deepPurple)),
                    TextSpan(
                      text: " ${loc.add}",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (viewModel.hasDays)
              IconButton(
                onPressed: () async {
                  final shouldDelete =
                      await viewModel.showDeleteConfirmationDialog(context, loc);
                  if (shouldDelete == true) {
                    await viewModel.removeLastDay();
                  }
                },
                icon: const Icon(Icons.delete),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSeriesSection(BuildContext context, AppLocalizations loc) {
    final viewModel = context.watch<ContainerExpandViewModel>();
    if (!viewModel.hasDays) return const SizedBox.shrink();

    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(loc.series,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 4,
            children: [
              ...listSeries(
                viewModel.exercise.days[viewModel.selectedDayIndex]!.series,
                viewModel.selectedSeriesIndex,
                viewModel.handleDaySelection,
              ),
            ],
          ),
        ),
        Row(
          spacing: 4,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side:
                    const BorderSide(color: Color.fromRGBO(196, 142, 239, .86)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed: viewModel.addNewSeries,
              child: const Icon(Icons.add),
            ),
            if (viewModel.hasSeries)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                      color: Color.fromRGBO(196, 142, 239, .86)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                onPressed: () async {
                  final shouldDelete =
                      await viewModel.showDeleteConfirmationDialog(context, loc);
                  if (shouldDelete == true) {
                    await viewModel.removeLastSeries();
                  }
                },
                child: const Icon(Icons.remove),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildRepetitionsSection(BuildContext context, AppLocalizations loc) {
    final viewModel = context.watch<ContainerExpandViewModel>();
    if (!viewModel.hasSeries) return const SizedBox.shrink();

    final repetitions = viewModel.selectedSeries?.repetitions ?? 0;

    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
          text: loc.repetitions,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        )),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(196, 142, 239, .86)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '$repetitions',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }
}
