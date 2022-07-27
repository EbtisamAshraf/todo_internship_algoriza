import 'package:dartz/dartz.dart';
import 'package:todo_internship_algoriza/core/errors/exceptions.dart';
import 'package:todo_internship_algoriza/features/tasks/data/data_sources/sql_db.dart';
import 'package:todo_internship_algoriza/features/tasks/data/models/task_model.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';

abstract class TasksLocalDataSource {
  Future<List<TaskEntity>> getAllTask();
  Future<Unit> deleteTask(int? taskId);
  Future<Unit> updateTask({ int? isCompleted,  int? isFavorite,  int? id});
  Future<Unit> addTask(TaskModel task);
}

class TasksLocalDataSourceImpl implements TasksLocalDataSource {
  final SqlDB sqlDB;

  TasksLocalDataSourceImpl({required this.sqlDB});

  @override
  Future<Unit> addTask(TaskModel task) async {
    int response = await sqlDB.insertData(task);
    if (response != 0) {
      return Future.value(unit);
    } else {
      throw AddDataException();
    }
  }

  @override
  Future<Unit> deleteTask(int? taskId) async {
    int response = await sqlDB.deleteData(taskId);
    if (response == 1) {
      return Future.value(unit);
    } else {
      throw DeleteDataException();
    }
  }

  @override
  Future<List<TaskModel>> getAllTask() async {
    List<Map> response = await sqlDB.readData();
    List<TaskModel> tasks =
        response.map<TaskModel>((e) => TaskModel.fromJson(e)).toList();
    if (tasks.isNotEmpty) {
      return tasks;
    } else {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> updateTask({ int? isCompleted,  int? isFavorite,  int? id}) async {
    int response = await sqlDB.updateData(isCompleted:isCompleted ,isFavorite: isFavorite,id:id );
    if (response == 1) {
      return Future.value(unit);
    } else {
      throw UpdateDataException();
    }
  }
}
