import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/muscle_title.dart';

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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TREINOS',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: Colors.black87,
                        offset: Offset(0, 2),
                        blurRadius: 10),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MuscleTitle(
                title: 'Braços',
                key: Key('braços'),
              ),
              SizedBox(
                height: 20,
              ),
              MuscleTitle(
                title: 'Peito',
                key: Key('peito'),
              ),
              SizedBox(
                height: 20,
              ),
              MuscleTitle(
                title: 'Pernas',
                key: Key('pernas'),
              ),
              SizedBox(
                height: 20,
              ),
              MuscleTitle(
                title: 'Costas',
                key: Key('costas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
