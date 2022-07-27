

import 'package:dartz/dartz.dart';
import 'package:todo_internship_algoriza/core/errors/failure.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/repositories/tasks_repository.dart';

class AddTaskUseCase {

  final TasksRepository repository;

  AddTaskUseCase(this.repository);

  Future<Either<Failure, Unit>> call(TaskEntity task) async {
    return await repository.addTask(task);
  }

}
