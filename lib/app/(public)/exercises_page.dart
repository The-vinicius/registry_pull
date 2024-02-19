import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  bool expan = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Routefly.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left_sharp),
        ),
        title: const Text(
          'Exercícios',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
            expansionCallback: (index, ex) {
              setState(() {
                expan = ex;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (context, ex) {
                  return const ListTile(
                    title: Text('sadsa'),
                  );
                },
                body: const ListTile(
                  title: Text('sadsa'),
                ),
                isExpanded: expan,
              ),
            ]),
      ),
    );
  }
}
