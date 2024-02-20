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
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
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
                    title: Text('Paralela'),
                  );
                },
                body: ListTile(
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data',
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(right: 5),
                              decoration: const BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              width: 60,
                              height: 30,
                              child: const Text(
                                '20/02',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(right: 5),
                              decoration: const BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              width: 60,
                              height: 30,
                              child: const Text(
                                '20/02',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add_circle_outline))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Series',
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(right: 5),
                              decoration: const BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              width: 30,
                              height: 30,
                              child: const Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(right: 5),
                              decoration: const BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              width: 30,
                              height: 30,
                              child: const Text(
                                '2',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Repetições: 5'),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              height: 50,
                              width: 10,
                              color: Colors.red,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              height: 50,
                              width: 10,
                              color: Colors.red,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              height: 50,
                              width: 10,
                              color: Colors.red,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              height: 50,
                              width: 10,
                              color: Colors.red,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              height: 50,
                              width: 10,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ]),
                ),
                isExpanded: expan,
              ),
            ]),
      ),
    );
  }
}
