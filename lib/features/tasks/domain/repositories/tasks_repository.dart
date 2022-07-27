
import 'package:dartz/dartz.dart';
import 'package:todo_internship_algoriza/core/errors/failure.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<TaskEntity>>> getAllTask();
  Future<Either<Failure, Unit>> deleteTask(int? taskId);
  Future<Either<Failure, Unit>> updateTask({ int? isCompleted,  int? isFavorite,  int? id});
  Future<Either<Failure, Unit>> addTask(TaskEntity task);
}