
import 'package:todo_internship_algoriza/features/tasks/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({ super.id, required super.taskTitle,  super.startTime,super.date,super.endTime , super.isCompleted , super.isFavorite , super.remind , super.repeat,super.color});

  factory TaskModel.fromJson(Map<dynamic, dynamic> json) {
    return TaskModel(
      id: json['id'],
      taskTitle: json['taskTitle'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isCompleted: json['isCompleted'],
      isFavorite: json['isFavorite'],
      remind: json['remind'],
      repeat: json['repeat'],
      color: json['color']
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id,
      'taskTitle': taskTitle,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
      'remind': remind,
      'color': color};
  }

}