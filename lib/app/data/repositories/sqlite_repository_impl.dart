import 'package:registry_pull/app/data/db/db.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';
import 'package:registry_pull/app/interactor/repositories/pull_repository.dart';

class SqluteRepositoryImpl extends PullRepository {
  @override
  Future<void> deleteDay(DayExerciseModel model) {
    // TODO: implement deleteDay
    throw UnimplementedError();
  }

  @override
  Future<void> deleteExercise(ExercisesModel model) {
    // TODO: implement deleteExercise
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSerie(SeriesModel model) {
    // TODO: implement deleteSerie
    throw UnimplementedError();
  }

  @override
  Future<List<ExercisesModel>> getExercises(String muscle) async {
    final db = await DB.instancia.database;
    final items = await db.query('exercicios');
    return items.map((e) => ExercisesModel.fromJson(e)).toList();
  }

  @override
  Future<void> insertDay(DayExerciseModel model, int id) async {
    final db = await DB.instancia.database;
    final data = {'date': model.date.toIso8601String(), 'exercicio_id': id};
    await db.insert('days', data);
  }

  @override
  Future<void> insertExercise(ExercisesModel model) async {
    final db = await DB.instancia.database;
    final data = {
      'nameMuscle': model.nameMuscle,
      'nameExercise': model.nameExercise
    };
    await db.insert('exercicios', data);
  }

  @override
  Future<void> insertSerie(SeriesModel model, int id) async {
    final db = await DB.instancia.database;
    final data = {
      'series': model.series,
      'repetitions': model.repetitions,
      'day_id': id
    };
    await db.insert('series', data);
  }
}

String query = '''
SELECT 
    exercicios.id AS exercicio_id, 
    exercicios.nameMuscle, 
    exercicios.nameExercise, 
    days.id AS day_id, 
    days.date, 
    series.id AS series_id, 
    series.series,
	  series.repetitions
FROM 
    exercicios
LEFT JOIN 
    days ON exercicios.id = days.exercicio_id
LEFT JOIN 
    series ON days.id = series.day_id;
''';
