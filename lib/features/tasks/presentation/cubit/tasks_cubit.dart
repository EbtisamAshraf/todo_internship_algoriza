import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_internship_algoriza/core/errors/failure.dart';
import 'package:todo_internship_algoriza/core/utils/app_colors.dart';
import 'package:todo_internship_algoriza/core/utils/app_strings.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/use_cases/add_task.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/use_cases/delete_task.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/use_cases/get_all_tasks.dart';
import 'package:todo_internship_algoriza/features/tasks/domain/use_cases/update_task.dart';
import 'package:intl/intl.dart';
import 'package:todo_internship_algoriza/features/tasks/data/models/enum_filtration.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(
      {required this.getAllTaskUseCase,
      required this.addTaskUseCase,
      required this.deleteTaskUseCase,
      required this.updateTaskUseCase})
      : super(TasksInitial());

  final GetAllTaskUseCase getAllTaskUseCase;
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  static TasksCubit get(context) => BlocProvider.of(context);

  final TextEditingController? titleController = TextEditingController();
  final TextEditingController? dateController = TextEditingController();
  final TextEditingController? startTimeController = TextEditingController();
  final TextEditingController? endTimeController = TextEditingController();

  DateTime selectedDateSchedule = DateTime.now();
  String strDateSchedule = DateFormat.yMd().format(DateTime.now());
  getSelectedDateSchedule(date) {
    emit(TasksInitial());
    selectedDateSchedule = DateTime.parse(date);
    strDateSchedule = DateFormat.yMd().format(selectedDateSchedule);
    debugPrint('$strDateSchedule');
    emit(GetSelectedDateSchedule());
    getFiltrationTask(filtration: Filtration.isDate);
  }

  late List<TaskEntity> filtrationTask;
  getFiltrationTask({
    Filtration? filtration,
    int? isCompleted,
    int? isFavorite,
  }) async {
    switch (filtration) {
      case Filtration.isCompleted:
        emit(FiltrationDataLoadingState());
        filtrationTask = allTasks
            .where((element) => element.isCompleted == isCompleted)
            .toList();
        if (filtrationTask.isEmpty) {
          emit(const FiltrationDataErrorState(msg: 'No Tasks'));
        } else {
          emit(FiltrationDataSuccessState(filtrationTask));
        }
        return filtrationTask;
      case Filtration.isFavorite:
        emit(FiltrationDataLoadingState());
        filtrationTask = allTasks
            .where((element) => element.isFavorite == isFavorite)
            .toList();
        if (filtrationTask.isEmpty) {
          emit(const FiltrationDataErrorState(msg: 'No Tasks'));
        } else {
          emit(FiltrationDataSuccessState(filtrationTask));
        }
        return filtrationTask;
      case Filtration.isDate:
        emit(FiltrationDataLoadingState());
        filtrationTask = allTasks.where((element) {
          debugPrint('date = $strDateSchedule');
          debugPrint('element.date = ${element.date}');
          return element.date == strDateSchedule;
        }).toList();
        debugPrint('filtrationTask = $filtrationTask');
        if (filtrationTask.isNotEmpty) {
          emit(FiltrationDataSuccessState(filtrationTask));
        } else {
          emit(const FiltrationDataErrorState(msg: 'No Tasks'));
        }
        return filtrationTask;
    }
  }

  bool isCompleted = false;
  bool completesState({bool? value, int? id}) {
    emit(TasksInitial());
    if (value == null) {
      isCompleted = isCompleted;
      emit(CompletesState());
    } else {
      isCompleted = value;
      emit(CompletesState());
    }

    return isCompleted;
  }

  bool reversIsCompleted() {
    emit(TasksInitial());
    isCompleted = !isCompleted;
    emit(ReversIsCheckedState());
    return isCompleted;
  }

  bool isFavorite = false;
  bool reversIsFavorite() {
    emit(TasksInitial());
    isFavorite = !isFavorite;
    emit(ReversIsFavorite());
    return isFavorite;
  }

  late String remindDropdownValue;
  getDropDownValue(String value) {
    emit(TasksInitial());
    remindDropdownValue = value;
    emit(GetDropDownValueState());
    return remindDropdownValue;
  }

  int? selectedColor;

  getSelectedColor(int index) {
    emit(TasksInitial());
    selectedColor = index;
    emit(GetSelectedColorState());
  }

  getColor(int? index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.indigo;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.pink;
      case 4:
        return Colors.teal;

      default:
        return AppColors.primaryColor;
    }
  }

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 2)))
      .toString();
  int selectedNumberRemind = 0;

  int convertRemindToNumber() {
    switch (remindDropdownValue) {
      case '10 min before':
        selectedNumberRemind = 10;
        return selectedNumberRemind;
      case '30 min before':
        selectedNumberRemind = 30;
        return selectedNumberRemind;
      case '1 hour before':
        selectedNumberRemind = 60;
        return selectedNumberRemind;
      case '1 day before':
        selectedNumberRemind = 1;
        return selectedNumberRemind;

      default:
        selectedNumberRemind = 0;
        return selectedNumberRemind;
    }
  }

  getDateFromUser(BuildContext context) async {
    emit(TasksInitial());
    DateTime? dateFromUser = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (dateFromUser != null) {
      selectedDate = dateFromUser;
      dateController!.text = DateFormat.yMd().format(selectedDate);
      emit(GetDateFromUserState());
    }
  }

  getStartDateFromUser(BuildContext context) async {
    emit(TasksInitial());
    TimeOfDay? startDateFromUser = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));

    startTime = startDateFromUser!.format(context);
    startTimeController!.text = startTime;
    emit(GetStartDateFromUserState());
  }

  getEndDateFromUser(BuildContext context) async {
    emit(TasksInitial());
    TimeOfDay? endDateFromUser = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
            DateTime.now().add(const Duration(hours: 2))));
    endTime = endDateFromUser!.format(context);
    endTimeController!.text = endTime;
    emit(GetEndDateFromUserState());
  }

  late List<TaskEntity> allTasks;
  Future<void> getTasks() async {
    emit(GetDataLoadingState());
    Either<Failure, List<TaskEntity>> response = await getAllTaskUseCase();
    emit(response.fold(
      (failure) => GetDataErrorState(
        msg(failure),
      ),
      (tasks) {
        allTasks = tasks;
        return GetDataLoadedState(tasks);
      },
    ));
  }

  Future<void> addTask() async {
    emit(AddOrDeleteOrUpdateLoadingState());
    TaskEntity task = TaskEntity(
      taskTitle: titleController!.text,
      date: DateFormat.yMd().format(selectedDate),
      startTime: startTime,
      endTime: endTime,
      remind: selectedNumberRemind,
      color: selectedColor,
      isCompleted: isCompleted ? 1 : 0,
      isFavorite: isFavorite ? 1 : 0,
    );
    Either<Failure, Unit> response = await addTaskUseCase(task);
    emit(
      response.fold(
        (failure) => AddOrDeleteOrUpdateErrorState(
          msg(failure),
        ),
        (_) {
          getTasks();
          return const AddOrDeleteOrUpdateSuccessState(
              AppStrings.addSuccessMsg);
        },
      ),
    );
  }

  Future<void> updateTask({int? isCompleted, int? isFavorite, int? id}) async {
    emit(AddOrDeleteOrUpdateLoadingState());
    Either<Failure, Unit> response = await updateTaskUseCase(
        isCompleted: isCompleted, isFavorite: isFavorite, id: id);
    emit(response.fold(
      (failure) => AddOrDeleteOrUpdateErrorState(
        msg(failure),
      ),
      (_) {
        getTasks();
        return const AddOrDeleteOrUpdateSuccessState(
            AppStrings.updateSuccessMsg);
      },
    ));
  }

  Future<void> deleteTask(int? taskId) async {
    emit(AddOrDeleteOrUpdateLoadingState());
    Either<Failure, Unit> response = await deleteTaskUseCase(taskId);
    emit(response.fold(
      (failure) => AddOrDeleteOrUpdateErrorState(
        msg(failure),
      ),
      (_) {
        getTasks();
        return const AddOrDeleteOrUpdateSuccessState(
            AppStrings.deleteSuccessMsg);
      },
    ));
  }

  String msg(Failure failure) {
    switch (failure.runtimeType) {
      case AddDataFailure:
        return AppStrings.addOrDeleteOrUpdateFailureMsg;
      case DeleteDataFailure:
        return AppStrings.addOrDeleteOrUpdateFailureMsg;
      case NoDataFailure:
        return AppStrings.emptyDataMsg;
      case UpdateDataFailure:
        return AppStrings.addOrDeleteOrUpdateFailureMsg;

      default:
        return AppStrings.unexpectedFailureMsg;
    }
  }
}
