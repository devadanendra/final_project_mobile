import 'package:final_project_mobile/models/task.dart';
import 'package:sqflite/sqflite.dart' as sql;

// Kelas DBHelper digunakan untuk berinteraksi dengan database SQLite
class DBHelper {
  static late sql.Database _db; // Variabel untuk menyimpan instance database
  static const String _tableName = 'tasks'; // Nama tabel dalam database

  // Fungsi untuk mendapatkan instance database atau membuatnya jika belum ada
  static Future<sql.Database> db() async {
    _db = await sql.openDatabase(
      'tasks.db', // Nama file database
      version: 1, // Versi database
      onCreate: (sql.Database database, int version) async {
        await createTables(database); // Membuat tabel ketika database dibuat
        print(
            'Database created!'); // Pesan yang dicetak saat database berhasil dibuat
      },
    );
    return _db;
  }

  // Fungsi untuk membuat tabel dalam database
  static Future<void> createTables(sql.Database database) async {
    await database.execute("CREATE TABLE $_tableName ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title TEXT, note TEXT, date TEXT, "
        "startTime TEXT, endTime TEXT, "
        "remind INTEGER, repeat INTEGER, "
        "color INTEGER, "
        "isCompleted INTEGER)");
  }

  // Fungsi untuk menyisipkan data tugas ke dalam database
  static Future<int> insert(Task? task) async {
    if (task == null) {
      throw ArgumentError('Task cannot be null');
    }
    print("insert function called");
    final dbInstance = await db(); // Inisialisasi database
    return await _db.insert(_tableName, task.toJson());
  }

  // Fungsi untuk melakukan query dan mendapatkan daftar tugas dari database
  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    final dbInstance = await db(); // Inisialisasi database
    return await dbInstance.query(_tableName);
  }

  // Fungsi untuk menghapus tugas dari database
  static Future<int> delete(Task task) async {
    final dbInstance = await db(); // Inisialisasi database
    try {
      print("Deleting task with ID: ${task.id}");
      return await dbInstance
          .delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
    } catch (e) {
      print("Error deleting task: $e");
      return -1; // Mengembalikan kode atau nilai khusus untuk menandakan kegagalan
    }
  }

  // Fungsi untuk memperbarui status penyelesaian tugas dalam database
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
