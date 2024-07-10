import 'package:flutter/material.dart';
import 'data/colors.dart';
import 'pages/onBoardingScreen.dart';// Import the custom colors file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Colors',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.background,
          error: Colors.red,
          onPrimary: AppColors.text,
          onSecondary: AppColors.text,
          onSurface: AppColors.text,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          color: AppColors.primary,
          titleTextStyle: TextStyle(
            color: AppColors.text,
            fontSize: 20.0,
          ),
          iconTheme: IconThemeData(
            color: AppColors.text,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.text),
          bodyMedium: TextStyle(color: AppColors.text),
          bodySmall: TextStyle(color: AppColors.text),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.text, backgroundColor: AppColors.primary,
          ),
        ),
      ),
      home: OnBoardingScreen(),
    );
  }
}


