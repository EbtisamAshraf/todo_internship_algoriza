
import 'package:dartz/dartz.dart';
import 'package:todo_internship_algoriza/core/errors/failure.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/repositories/tasks_repository.dart';

class GetAllTaskUseCase {

  final TasksRepository repository;

  GetAllTaskUseCase(this.repository);

  Future<Either<Failure, List<TaskEntity>>>call() async {
    return await repository.getAllTask();
  }

}