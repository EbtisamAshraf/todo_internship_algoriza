import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_internship_algoriza/config/routes/app_routes.dart';
import 'package:todo_internship_algoriza/config/themes/app_theme.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:todo_internship_algoriza/features/tasks/presentation/screens/home_screen.dart';
import 'package:todo_internship_algoriza/injection_container.dart'as di ;


class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create:   (context) => di.sl<TasksCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do',
        theme: appTheme(),
        home: const HomeScreen(),
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
