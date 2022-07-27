import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';

class TaskBoardWidget extends StatelessWidget {
  const TaskBoardWidget({Key? key, required this.task}) : super(key: key);
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 7.0, bottom: 1.0, left: 15.0, right: 15.0),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value:task.isCompleted == null  ? TasksCubit.get(context).isCompleted : task.isCompleted == 1? true : false,
                onChanged: (bool? value) {
                  TasksCubit.get(context).completesState(value: value);
                  TasksCubit.get(context).getColor(task.color);
                },
                checkColor: Colors.white,
                activeColor: TasksCubit.get(context).getColor(task.color),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                side: BorderSide(
                    color: TasksCubit.get(context).getColor(task.color),
                    width: 2),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text(task.taskTitle,
                    style: Theme.of(context).textTheme.titleMedium),
              )),
              PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      TasksCubit.get(context).reversIsCompleted();
                      TasksCubit.get(context).updateTask(
                          isCompleted:
                              TasksCubit.get(context).isCompleted ? 1 : 0,
                          isFavorite: task.isFavorite,
                          id: task.id);
                      break;
                    case 2:
                      TasksCubit.get(context).reversIsFavorite();
                      TasksCubit.get(context).updateTask(
                          isCompleted: task.isCompleted,
                          isFavorite:
                              TasksCubit.get(context).isFavorite ? 1 : 0,
                          id: task.id);
                      break;
                    case 3:
                      TasksCubit.get(context).deleteTask(task.id);
                  }

                  debugPrint(value.toString());
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 1,
                    child: task.isCompleted == 1
                        ? const Text("Uncompleted task")
                        : const Text("Completed task"),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: task.isFavorite == 1
                        ? const Text("remove from favorites")
                        : const Text("Add to favorites"),
                  ),
                  const PopupMenuItem(
                    value: 3,
                    child: Text("Remove task"),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
