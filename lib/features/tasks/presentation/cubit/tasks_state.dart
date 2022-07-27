part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {
  const TasksState();
  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class CompletesState extends TasksState {}
class ReversIsFavorite extends TasksState {}
class ReversIsCheckedState extends TasksState {}
class GetDateFromUserState extends TasksState {}
class GetStartDateFromUserState extends TasksState {}
class GetEndDateFromUserState extends TasksState {}
class GetSelectedDateSchedule extends TasksState {}

class GetDropDownValueState extends TasksState {}
class GetColorState extends TasksState {}
class GetSelectedColorState extends TasksState {}
class GetDataLoadingState extends TasksState {}
class GetDataLoadedState extends TasksState {
  final List<TaskEntity> task;

  const GetDataLoadedState(this.task);
  @override
  List<Object> get props => [task];
}
class GetDataErrorState extends TasksState {
  final String msg;

  const GetDataErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}
class FiltrationDataLoadingState extends TasksState {}
class FiltrationDataSuccessState extends TasksState {
  final List<TaskEntity> task;

  const FiltrationDataSuccessState(this.task);
  @override
  List<Object> get props => [task];
}
class FiltrationDataErrorState extends TasksState {
  final String msg;

  const FiltrationDataErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}
class AddOrDeleteOrUpdateLoadingState extends TasksState {}

class AddOrDeleteOrUpdateSuccessState extends TasksState {
  final String msg;

  const AddOrDeleteOrUpdateSuccessState(this.msg);
  @override
  List<Object> get props => [msg];
}

class AddOrDeleteOrUpdateErrorState extends TasksState {
  final String msg;

  const AddOrDeleteOrUpdateErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}
