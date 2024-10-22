import 'package:crackincode_test/core/database/app_database.dart';
import 'package:crackincode_test/core/model/task.dart';

class Repository {
  final AppDatabase database = AppDatabase();

  Future<List<Task>> getTask() async {
    final db = await database.initDatabase();
    final List<Map<String, Object?>> task = await db.query(database.tableName);
    return task.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> addTask(Task task) async {
    final db = await database.initDatabase();
    return db.insert(database.tableName, task.toMap());
  }

  Future<int> updateTask(Task task) async {
    final db = await database.initDatabase();
    return db.update(database.tableName, task.toMap(),
        where: "id = ?", whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await database.initDatabase();
    return db.delete(database.tableName, where: "id =?", whereArgs: [id]);
  }
}
