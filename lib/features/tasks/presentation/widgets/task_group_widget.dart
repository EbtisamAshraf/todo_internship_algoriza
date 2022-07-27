import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_internship_algoriza/core/utils/constants.dart';
import 'package:todo_internship_algoriza/core/utils/media_query_values.dart';
import 'package:todo_internship_algoriza/core/widgets/custom_error_widget.dart';
import 'package:todo_internship_algoriza/core/widgets/custom_loading_widget.dart';
import 'package:todo_internship_algoriza/features/tasks/data/models/enum_filtration.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/widgets/task_board_widget.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/widgets/task_schedule_widget.dart';

class TaskGroupWidget extends StatelessWidget {
  TaskGroupWidget({
    Key? key,
    this.isFiltration = false,
    this.isSchedule = false,
    this.filtration,
    this.isCompleted,
    this.isFavorite,
    this.date,
  }) : super(key: key);

  final bool isFiltration;
  final bool isSchedule;
  final Filtration? filtration;
  final int? isCompleted;
  final int? isFavorite;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        if (state is AddOrDeleteOrUpdateSuccessState) {
          Constants.showToast(msg: state.msg);
        }
      },
      builder: (context, state) {

        if (state is GetDataLoadingState || state is FiltrationDataLoadingState ) {
          return const CustomLoadingWidget();
        } else if (state is GetDataErrorState || state is FiltrationDataErrorState ) {
          return const CustomErrorWidget(msg: 'No Tasks');
        } else if (state is GetDataLoadedState || state is FiltrationDataSuccessState || state is GetSelectedDateSchedule ) {
          isFiltration ?
            TasksCubit.get(context).getFiltrationTask(
              filtration: filtration,
              isFavorite: isFavorite,
              isCompleted: isCompleted,
            ) : null ;


          return SizedBox(
            height: context.height,
            child: ListView.builder(
                itemBuilder: (context, index) => isSchedule
                    ?  TaskScheduleWidget(task: TasksCubit.get(context).allTasks[index],)
                    : TaskBoardWidget(
                        task: isFiltration
                            ? TasksCubit.get(context).filtrationTask[index]
                            : TasksCubit.get(context).allTasks[index],
                      ),
                itemCount: isFiltration
                    ? TasksCubit.get(context).filtrationTask.length
                    : TasksCubit.get(context).allTasks.length),
          );
        }
        return const CustomLoadingWidget();
      },
    );
  }
}
