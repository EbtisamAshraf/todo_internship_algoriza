import 'package:flutter/material.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';

class TaskScheduleWidget extends StatelessWidget {
  const TaskScheduleWidget({Key? key, required this.task}) : super(key: key);
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),

        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        // height: 90 ,
        width: double.infinity,

        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(15.0)),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.startTime.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold,color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  task.taskTitle,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
              ],
            ),
            Checkbox(
              value: task.isCompleted == 1 ? true :false,
              onChanged:(_){},
              checkColor: TasksCubit.get(context).getColor(task.color),
              activeColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              side:  BorderSide(color:TasksCubit.get(context).getColor(task.color), width: 2),
            ),
          ],
        ),
      ),
    );
  }
}
