
import 'package:dartz/dartz.dart';
import 'package:todo_internship_algoriza/core/errors/failure.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/repositories/tasks_repository.dart';

class UpdateTaskUseCase {

  final TasksRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<Either<Failure, Unit>> call({ int? isCompleted,  int? isFavorite,  int? id}) async {
    return await repository.updateTask(isCompleted:isCompleted ,isFavorite: isFavorite,id:id);
  }

}