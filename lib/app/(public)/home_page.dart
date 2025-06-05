import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/constants/muscles.dart';
import 'package:registry_pull/app/core/widgets/muscle_widget.dart';
import 'package:registry_pull/app/interactor/atoms/exercise_atom.dart';
import 'package:registry_pull/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    List<String> localMuscles = [
      loc.arms,
      loc.chest,
      loc.legs,
      loc.back,
    ];
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withAlpha(51),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    loc.workouts,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      loc.description,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                      valueListenable: selectedMuscle,
                      builder: (context, value, child) {
                        if (value.isEmpty) {
                          return const Text('');
                        }
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Text(loc.lastTraining),
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20)),
                                width: 50,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/muscle/${iconM[value]}.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                )),
                          ],
                        );
                      }),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: muscles.length,
                  itemBuilder: (context, index) {
                    return MuscleWidget(
                        muscle: muscles[index],
                        localMuscle: localMuscles[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
