import 'package:get_it/get_it.dart';
import 'package:todo_internship_algoriza/features/tasks/data/data_sources/sql_db.dart';
import 'package:todo_internship_algoriza/features/tasks/data/data_sources/tasks_local_data_source.dart';
import 'package:todo_internship_algoriza/features/tasks/data/repositories/tasks_repository_impl.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/use_cases/add_task.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/use_cases/delete_task.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/use_cases/get_all_tasks.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/use_cases/update_task.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///feature
  //bloc
  sl.registerFactory(() => TasksCubit(
      getAllTaskUseCase: sl(),
      updateTaskUseCase: sl(),
      deleteTaskUseCase: sl(),
      addTaskUseCase: sl()));

//   // repo
  sl.registerLazySingleton<TasksRepository>(() => TasksRepositoryImpl(
        tasksLocalDataSource: sl(),
      ));
  // date source
  sl.registerLazySingleton<TasksLocalDataSource>(
      () => TasksLocalDataSourceImpl(sqlDB: sl()));

  // use cases
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => GetAllTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));

  /// external

  sl.registerLazySingleton(() => SqlDB());
}
