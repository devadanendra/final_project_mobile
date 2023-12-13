import 'package:final_project_mobile/models/task.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/foundation.dart';

class DBHelper {
  static late sql.Database _db;
  static const String _tableName = 'tasks';

  static Future<sql.Database> db() async {
    _db = await sql.openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        print(
            'Database created!'); // Print a message once the database is created
      },
    );
    return _db;
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("CREATE TABLE $_tableName ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title TEXT, note TEXT, date TEXT, "
        "startTime TEXT, endTime TEXT, "
        "remind INTEGER, repeat INTEGER, "
        "color INTEGER, "
        "isCompleted INTEGER)");
  }

  static Future<int> insert(Task? task) async {
    if (task == null) {
      throw ArgumentError('Task cannot be null');
    }
    print("insert function called");
    final dbInstance = await db(); // Initialize database
    return await _db.insert(_tableName, task.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    final dbInstance = await db(); // Initialize database
    return await dbInstance.query(_tableName);
  }

  static Future<int> delete(Task task) async {
    final dbInstance = await db(); // Initialize database
    try {
      print("Deleting task with ID: ${task.id}");
      return await dbInstance
          .delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
    } catch (e) {
      print("Error deleting task: $e");
      return -1; // Return a specific error code or value to indicate failure
    }
  }

  static update(int id) async {
    return await _db.rawUpdate(
      '''
      UPDATE tasks 
      SET isCompleted = ?
      WHERE id = ?
''',
      [1, id],
    );
  }
}
