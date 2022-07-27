
import 'package:dartz/dartz.dart';
import 'package:todo_internship_algoriza/core/errors/failure.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/repositories/tasks_repository.dart';

class DeleteTaskUseCase {

  final TasksRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int? taskId) async {
    return await repository.deleteTask(taskId);
  }

}