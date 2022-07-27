import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String taskTitle;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? isCompleted;
  final int? isFavorite;
  final int? remind;
  final String? repeat;
  final int? color;

  const TaskEntity(
      { this.id,
      required this.taskTitle,
      this.date,
       this.startTime,
      this.endTime,
       this.isCompleted ,
       this.isFavorite ,
      this.remind,
      this.repeat,
        this.color
      });

  @override
  List<Object?> get props => [
        id,
        taskTitle,
        date,
        startTime,
        endTime,
        isCompleted,
        isFavorite,
        remind,
        repeat,
        color
      ];
}
