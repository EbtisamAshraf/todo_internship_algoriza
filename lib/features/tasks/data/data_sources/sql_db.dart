
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:todo_internship_algoriza/features/tasks/data/models/task_model.dart';
class SqlDB {

  static Database? _database;

  String tableName = 'my_tasks';

  Map columns = {
    'id': 'id',
    'taskTitle': 'taskTitle',
    'date':  'date',
    'startTime': 'startTime',
    'endTime': 'endTime',
    'isCompleted': 'isCompleted',
    'isFavorite': 'isFavorite',
    'remind': 'remind',
    'repeat': 'repeat',
    'color': 'color',
  };

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = p.join(databasePath, 'tasks.db');
    Database myDd = await openDatabase(path, onCreate: onCreate, version: 1,);
    debugPrint('initDatabase...........................');
    return myDd;
  }

  onCreate(Database database, int version) async {


      await database.execute('''
 create table $tableName ( 
  ${columns['id']} integer primary key autoincrement not null, 
  ${columns['taskTitle']} text not null ,
  ${columns['date']} text ,
  ${columns['startTime']} text ,
  ${columns['endTime']} text ,
  ${columns['isCompleted']} integer ,
  ${columns['isFavorite']} integer ,
  ${columns['remind']} integer , 
  ${columns['color']} integer 
  )
''');
      debugPrint('onCreate...................');


  }

  readData() async {
    Database? myDatabase = await database;
    // List<Map> response = await myDatabase!.query(tableName);
    List<Map> response = await myDatabase!.rawQuery('SELECT * FROM $tableName');
    debugPrint('readData...................$response');
    return response;
  }

  insertData(TaskModel task) async {
    Database? myDatabase = await database;
    int response = await myDatabase!.insert(tableName, task.toJson() );
    return response;
  }

  updateData(TaskModel task) async {
    Database? myDatabase = await database;
    int response = await myDatabase!.rawUpdate('''
      UPDATE $tableName
      SET ${columns['isCompleted']} = ?,
          ${columns['isFavorite']} = ?
      WHERE
           ${columns['id']} = ?
    ''',
    [task.isCompleted,task.isFavorite,task.id]);
    //  int response = await myDatabase!.update(tableName, task.toJson(),where: '${columns['id']}= ?',whereArgs: [task.id] );
    return response;
  }

  // updateIsFavorite(TaskModel task) async {
  //   Database? myDatabase = await database;
  //   int response = await myDatabase!.rawUpdate('''
  //     UPDATE $tableName
  //     SET ${columns['isFavorite']} = ?
  //
  //     WHERE
  //          ${columns['id']} = ?
  //   ''',
  //       [task.isFavorite,task.id]);
  //   //  int response = await myDatabase!.update(tableName, task.toJson(),where: '${columns['id']}= ?',whereArgs: [task.id] );
  //   return response;
  // }

  deleteData(int? taskId) async {
    Database? myDatabase = await database;
    int response = await myDatabase!.delete(tableName,where:'${columns['id']}= ?',whereArgs: [taskId] );
    // int response = await myDatabase!
    //     .rawDelete('''DELETE FROM $tableName WHERE ${columns['id']}= $taskId''');
    return response;
  }

  deleteAllData() async {
    String databasePath = await getDatabasesPath();
    String path = p.join(databasePath, 'tasks.db');
    await deleteDatabase(path);
    debugPrint('deleteAllData...................');
  }
}