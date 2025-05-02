import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registry_pull/app/core/widgets/container_expand.dart';
import 'package:registry_pull/app/injector.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/routes.dart';
import 'package:routefly/routefly.dart';

void main() {
  testWidgets('expansion', (tester) async {
    final exercise = ExercisesModel(
      id: '',
      nameMuscle: 'braços',
      nameExercise: 'paralelas',
      days: const [],
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ContainerExpand(exercise: exercise),
      ),
    ));
    // tester.pumpAndSettle();
    expect(find.byKey(const Key('expansion')), findsOneWidget);
  }, tags: 'pages');

  testWidgets('add ex', (tester) async {
    registerInstances();
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: Routefly.routerConfig(
            routes: routes, initialPath: routePaths.splash),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('braços')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('add')));
    await tester.pumpAndSettle();

    final nameKey = find.byKey(const Key('name_key'));
    await tester.tap(nameKey);
    await tester.pumpAndSettle();

    await tester.enterText(nameKey, 'paralelas');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('save_key')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('certo')), findsOneWidget);
  }, tags: 'pages');
}
