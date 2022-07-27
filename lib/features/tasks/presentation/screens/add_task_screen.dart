import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_internship_algoriza/core/widgets/custom_button.dart';
import 'package:todo_internship_algoriza/core/widgets/custom_drop_down_button.dart';
import 'package:todo_internship_algoriza/core/widgets/custom_text_form_field.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(title: const Text('Add task')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              title: 'Title',
                              hintText: 'Task',
                              controller:
                                  TasksCubit.get(context).titleController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter task';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            CustomTextFormField(
                              controller:
                                  TasksCubit.get(context).dateController,
                              title: 'Date',
                              hintText: DateFormat.yMd().format(DateTime.now()),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  TasksCubit.get(context)
                                      .getDateFromUser(context);
                                },
                                icon: const Icon(Icons.date_range),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: TasksCubit.get(context)
                                        .startTimeController,
                                    title: 'Start time',
                                    hintText: TasksCubit.get(context).startTime,
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        TasksCubit.get(context)
                                            .getStartDateFromUser(context);
                                      },
                                      icon: const Icon(
                                          Icons.access_time_outlined),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: TasksCubit.get(context)
                                        .endTimeController,
                                    title: 'End time',
                                    hintText: TasksCubit.get(context).endTime,
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        TasksCubit.get(context)
                                            .getEndDateFromUser(context);
                                      },
                                      icon: const Icon(
                                          Icons.access_time_outlined),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const CustomDropDownButton(
                                title: 'Remind',
                                item: [
                                  '10 min before',
                                  '30 min before',
                                  '1 hour before',
                                  '1 day before'
                                ],
                                defaultValue: '10 min before'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Color',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Row(
                                    children: List.generate(
                                  5,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      TasksCubit.get(context)
                                          .getSelectedColor(index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: TasksCubit.get(context)
                                                  .selectedColor ==
                                              index
                                          ? CircleAvatar(
                                              radius: 19,
                                              backgroundColor:
                                                  TasksCubit.get(context)
                                                      .getColor(index),
                                            )
                                          : CircleAvatar(
                                              radius: 15,
                                              backgroundColor:
                                                  TasksCubit.get(context)
                                                      .getColor(index),
                                            ),
                                    ),
                                  ),
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        bottomSheet: CustomButton(
          text: 'Create Task',
          onTap: () {
            if (formKey.currentState!.validate()) {
              TasksCubit.get(context).addTask();
              Navigator.of(context).pop();
            }
          },
        ));
  }
}
