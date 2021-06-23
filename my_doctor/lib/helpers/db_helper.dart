import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, 'database.db'),
      onCreate: (db, version) async => await _createDb(db),
      version: 1,
    );
  }

  static Future<void> _createDb(sql.Database db) async {
    await db.execute(
        'CREATE TABLE heart_diseases(id TEXT PRIMARY KEY, predict REAL, sex INTEGER, cp INTEGER, fbs INTEGER, restecg INTEGER, exang INTEGER, thal TEXT, ca INTEGER, age INTEGER, trestbps INTEGER, chol INTEGER, thalach INTEGER, oldpeak REAL, slope INTEGER)');
    await db.execute(
        'CREATE TABLE diabetics(id TEXT PRIMARY KEY, predict REAL, glucose INTEGER, bloodPressure INTEGER, skinThickness INTEGER, insulin INTEGER, bmi REAL, diabetesPedigreeFunction REAL, age INTEGER)');
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> close() async {
    final db = await DBHelper.database();
    await db.close();
  }
}
