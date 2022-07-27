import 'package:flutter/material.dart';
import 'package:todo_internship_algoriza/core/utils/app_strings.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/screens/add_task_screen.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/screens/home_screen.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/screens/schedule_screen.dart';


class Routes {
  static const String initRoute = '/';
  static const String scheduleRoute = '/Schedule';
  static const String addTaskRoute = '/addTask';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.scheduleRoute:
        return MaterialPageRoute(builder: (_) => const ScheduleScreen());

      case Routes.addTaskRoute:
        return MaterialPageRoute(builder: (_) => const AddTaskScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
