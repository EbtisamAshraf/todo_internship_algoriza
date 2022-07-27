

import 'package:dartz/dartz.dart';
import 'package:todo_internship_algoriza/core/errors/exceptions.dart';
import 'package:todo_internship_algoriza/core/errors/failure.dart';
import 'package:todo_internship_algoriza/features/tasks/data/data_sources/tasks_local_data_source.dart';
import 'package:todo_internship_algoriza/features/tasks/data/models/task_model.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/repositories/tasks_repository.dart';




class TasksRepositoryImpl implements TasksRepository{

final TasksLocalDataSource tasksLocalDataSource;


TasksRepositoryImpl({required this.tasksLocalDataSource});

  @override
  Future<Either<Failure, Unit>> addTask(TaskEntity task) async {
    final TaskModel taskModel = TaskModel(
      id: task.id,
      startTime: task.startTime,
      taskTitle: task.taskTitle,
      color: task.color,
      date: task.date,
      endTime: task.endTime,
      isCompleted: task.isCompleted,
      isFavorite: task.isFavorite,
      remind: task.remind,
      repeat: task.repeat,
    );
    try{
      await tasksLocalDataSource.addTask(taskModel);
      return right(unit);
    }on AddDataException {
      return Left(AddDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(int? taskId)async{
    try{
      await tasksLocalDataSource.deleteTask(taskId);
      return right(unit);
    }on DeleteDataException {
      return Left(DeleteDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTask() async {
    try{
     final tasks =await tasksLocalDataSource.getAllTask();
      return right(tasks);
    }on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTask(TaskEntity task) async{
    final TaskModel taskModel = TaskModel(
      id: task.id,
      startTime: task.startTime,
      taskTitle: task.taskTitle,
      color: task.color,
      date: task.date,
      endTime: task.endTime,
      isCompleted: task.isCompleted,
      isFavorite: task.isFavorite,
      remind: task.remind,
      repeat: task.repeat,
    );
    try{
      await tasksLocalDataSource.updateTask(taskModel);
      return right(unit);
    }on UpdateDataException {
      return Left(UpdateDataFailure());
    }
  }

}