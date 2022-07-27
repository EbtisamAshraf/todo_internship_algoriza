import 'package:flutter/material.dart';
import 'package:todo_internship_algoriza/core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    iconTheme: IconThemeData(color: AppColors.primaryColor,),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black,),
      elevation: 0.5,
        titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18 ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
    ),
  
  );
}
