import 'package:flutter/material.dart';
import 'package:registry_pull/app/core/widgets/muscle_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/gym3.jpg'), fit: BoxFit.cover),
        ),
        child: const Column(
          children: [
            Text(
              'Treinos',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Colors.white70,
                shadows: [
                  Shadow(
                      color: Colors.black87,
                      offset: Offset(0, 2),
                      blurRadius: 4),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MuscleTitle(title: 'Braços'),
            SizedBox(
              height: 20,
            ),
            MuscleTitle(title: 'Peito'),
            SizedBox(
              height: 20,
            ),
            MuscleTitle(title: 'Pernas'),
            SizedBox(
              height: 20,
            ),
            MuscleTitle(title: 'Costas'),
          ],
        ),
      ),
    );
  }
}
