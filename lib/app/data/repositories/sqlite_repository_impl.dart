import 'package:registry_pull/app/data/db/db.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:registry_pull/app/interactor/models/exercises_model.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';
import 'package:registry_pull/app/interactor/repositories/pull_repository.dart';

class SqliteRepositoryImpl extends PullRepository {
  @override
  Future<List<ExercisesModel>> getExercises(String muscle) async {
    final db = await DB.instancia.database;
    final items = await db.query('exercicios');
    return items.map((e) => ExercisesModel.fromJson(e)).toList();
  }

  @override
  Future<List<DayExerciseModel>> getDays(int id) async {
    final db = await DB.instancia.database;
    final items = await db.query('days', where: 'id = ?', whereArgs: [id]);
    return items.map((e) => DayExerciseModel.fromJson(e)).toList();
  }

  @override
  Future<List<SeriesModel>> getSeries(int id) async {
    final db = await DB.instancia.database;
    final items = await db.query('series', where: 'id = ?', whereArgs: [id]);
    return items.map((e) => SeriesModel.fromJson(e)).toList();
  }

  @override
  Future<void> insertDay(DayExerciseModel model, int id) async {
    final db = await DB.instancia.database;
    final data = {'date': model.date.toIso8601String(), 'exercicio_id': id};
    if (model.id < 0) {
      await db.insert('days', data);
    } else if (model.id > 0) {
      db.update('days', data, where: 'id = ?', whereArgs: [model.id]);
    }
  }

  @override
  Future<void> insertExercise(ExercisesModel model) async {
    final db = await DB.instancia.database;
    final data = {
      'nameMuscle': model.nameMuscle,
      'nameExercise': model.nameExercise
    };
    if (model.id < 0) {
      await db.insert('exercicios', data);
    } else if (model.id > 0) {
      db.update('exercicios', data, where: 'id = ?', whereArgs: [model.id]);
    }
  }

  @override
  Future<void> insertSerie(SeriesModel model, int id) async {
    final db = await DB.instancia.database;
    final data = {
      'series': model.series,
      'repetitions': model.repetitions,
      'day_id': id
    };
    if (model.id < 0) {
      await db.insert('series', data);
    } else if (model.id > 0) {
      db.update('series', data, where: 'id = ?', whereArgs: [model.id]);
    }
  }

  @override
  Future<void> deleteExercise(int id) async {
    final db = await DB.instancia.database;
    await db.delete('exercicios', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteDay(int id) async {
    final db = await DB.instancia.database;
    await db.delete('days', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteSerie(int id) async {
    final db = await DB.instancia.database;
    await db.delete('series', where: 'id = ?', whereArgs: [id]);
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
