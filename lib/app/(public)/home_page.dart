import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/constants/muscles.dart';
import 'package:registry_pull/app/core/widgets/muscle_widget.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      tileMode: TileMode.mirror,
                      colors: [Colors.orangeAccent, Colors.lightBlueAccent],
                      begin: Alignment.centerLeft,
                    ),
                    color: Colors.blueAccent, // Cor de fundo
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    loc.workouts,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  loc.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
