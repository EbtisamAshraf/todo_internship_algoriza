import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_internship_algoriza/core/utils/app_colors.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton(
      {Key? key,
      required this.title,
      required this.item,
      required this.defaultValue})
      : super(key: key);

  final String title;
  final List<String> item;
  final String defaultValue;
  @override
  Widget build(BuildContext context) {
    String dropdownValue = defaultValue;
    TasksCubit.get(context).remindDropdownValue = dropdownValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 15,
        ),
        BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: AppColors.hintColor.withOpacity(0.2),
              ),
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(2),
                value: TasksCubit.get(context).remindDropdownValue,
                underline: Container(),
                icon: const Icon(Icons.keyboard_arrow_down),
                elevation: 16,
                style: TextStyle(color: AppColors.hintColor),
                isExpanded: true,
                onChanged: (String? value) {
                  TasksCubit.get(context).getDropDownValue(value!);
                  TasksCubit.get(context).convertRemindToNumber();
                },
                items: item.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            );
          },
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
