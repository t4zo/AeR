import 'package:AeR/setting.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as SqfLite;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future _onConfigure(Database db) async {
    db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<Database> database() async {
    final dbPath = await SqfLite.getDatabasesPath();

    return SqfLite.openDatabase(
      path.join(dbPath, '$DB_NAME.db'),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE $TBL_RESPONSAVEIS('
            'id INTEGER PRIMARY KEY,'
            'nome TEXT,'
            'cpf TEXT'
            ')');
        await db.execute('CREATE TABLE $TBL_ALUNOS('
            'id INTEGER PRIMARY KEY,'
            'responsavelId INTEGER,'
            'nome TEXT,'
            'escolaId INTEGER,'
            'escola TEXT,'
            'serieId INTEGER,'
            'serie TEXT,'
            'turnoId INTEGER,'
            'turno TEXT'
            // 'FOREIGN KEY (responsavelId) REFERENCES $TBL_RESPONSAVEIS (id) ON DELETE NO ACTION ON UPDATE NO ACTION,'
            ')');
        return db.execute('CREATE TABLE $TBL_AULAS('
            'id INTEGER PRIMARY KEY,'
            'alunoId INTEGER,'
            'disciplinaId INTEGER,'
            'disciplina TEXT,'
            'titulo TEXT,'
            'status TEXT,'
            'desafio TEXT,'
            'resposta TEXT,'
            'feedback TEXT,'
            'url TEXT'
            // 'FOREIGN KEY (alunoId) REFERENCES $TBL_ALUNOS (id) ON DELETE NO ACTION ON UPDATE NO ACTION,'
            ')');
      },
      onConfigure: _onConfigure,
      version: 1,
    );
  }

  static Future insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.insert(table, data,
        conflictAlgorithm: SqfLite.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object>>> read(String table) async {
    final db = await DBHelper.database();

    return db.query(table);
  }
}
