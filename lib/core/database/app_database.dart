import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  String databaseName = 'task_database.db';
  String tableName = 'task';
  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            isCompleted INTEGER NOT NULL
          )
          ''');
    });
  }
}
