import 'package:flutter/material.dart';
import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_internship_algoriza/core/utils/app_colors.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';

class HorizontalCalendarWidget extends StatelessWidget {
  const HorizontalCalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TasksCubit.get(context).selectedDateSchedule = DateTime.now();
    return SizedBox(
      height: 100,
      child: AnimatedHorizontalCalendar(
            tableCalenderIcon: const Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
            date: TasksCubit.get(context).selectedDateSchedule,
            textColor: Colors.black45,
            backgroundColor: Colors.white,
            tableCalenderButtonColor: AppColors.primaryColor,
            tableCalenderThemeData: ThemeData.light().copyWith(
              shadowColor: AppColors.primaryColor,
              primaryColor: AppColors.primaryColor,
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(primary: AppColors.primaryColor)
                  .copyWith(secondary: AppColors.hintColor),
            ),
            selectedColor: AppColors.primaryColor,
            onDateSelected: (date) {
              TasksCubit.get(context).getSelectedDateSchedule(date);
              TasksCubit.get(context). getFiltrationTask();
            },
            unSelectedBoxShadow: BoxShadow(
              color: AppColors.primaryColor,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          )
    );
  }
}
