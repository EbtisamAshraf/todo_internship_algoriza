import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_internship_algoriza/app.dart';
import 'package:todo_internship_algoriza/core/utils/bloc_observer.dart';
import 'package:todo_internship_algoriza/injection_container.dart'as di ;





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
        () {
      runApp(const ToDoApp());
    },
    blocObserver: MyBlocObserver(),
  );
}


