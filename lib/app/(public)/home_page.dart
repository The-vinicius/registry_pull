import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/constants/muscles.dart';
import 'package:registry_pull/app/core/widgets/muscle_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/gym4.png'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'TREINOS',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: Colors.black87,
                        offset: Offset(0, 2),
                        blurRadius: 15),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(30),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: muscles.length,
                  itemBuilder: (context, index) {
                    return MuscleWidget(muscle: muscles[index]);
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
