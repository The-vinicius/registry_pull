import 'package:sqflite/sqflite.dart';

class DB {
  //construtor com acesso privado
  DB._();

  //criar uma instancia de db
  static final DB instancia = DB._();

  //instancia do sqlite
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      'pull.db',
      onCreate: _onCreate,
      version: 1,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(_series);
    await db.execute(_days);
    await db.execute(_exercice);
  }

  String get _exercice => '''
    CREATE TABLE exercicios (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      nameMuscle TEXT,
      nameExercise TEXT
    );    
    ''';

  String get _days => '''
    CREATE TABLE days (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      date TEXT,
      exercicio_id INTEGER,
      FOREIGN KEY (exercicio_id) REFERENCES exercicios(id) ON DELETE CASCADE
    );    
    ''';

  String get _series => '''
    CREATE TABLE series (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      series INT, 
      repetitions INT,
      day_id INTEGER,
      FOREIGN KEY (day_id) REFERENCES days(id) ON DELETE CASCADE 
    );    
    ''';
}
