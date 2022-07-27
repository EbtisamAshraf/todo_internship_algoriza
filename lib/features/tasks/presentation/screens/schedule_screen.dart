import 'package:flutter/material.dart';
import 'package:todo_internship_algoriza/features/tasks/data/models/enum_filtration.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/widgets/horizontal_calendar_widget.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/widgets/task_group_widget.dart';


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    TasksCubit.get(context).getTasks();
    TasksCubit.get(context).getFiltrationTask(filtration: Filtration.isDate);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Schedule')),
        body: Column(
            children: [
              const HorizontalCalendarWidget(),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: TaskGroupWidget(
                isFiltration: true,
                isSchedule: true,
                filtration: Filtration.isDate,
              ),),
            ],),);
  }}
