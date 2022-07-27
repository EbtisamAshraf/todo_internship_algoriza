import 'package:flutter/material.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';

class TaskScheduleWidget extends StatelessWidget {
  const TaskScheduleWidget({Key? key, required this.task}) : super(key: key);
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),

        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        // height: 90 ,
        width: double.infinity,

        decoration: BoxDecoration(
            color: TasksCubit.get(context).getColor(task.color),
            borderRadius: BorderRadius.circular(15.0)),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.startTime.toString(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  task.taskTitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                    )),
                child: task.isCompleted == 1
                    ? const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 20,
                      )
                    : null)
          ],
        ),
      ),
    );
  }
}
