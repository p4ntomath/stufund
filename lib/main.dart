import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufund/pages/HomePage.dart';
import 'package:stufund/pages/authenticationPages/confirmCodePage.dart';
import 'package:stufund/pages/authenticationPages/forgotPassword.dart';

import 'configs/amplifyconfiguration.dart';
import 'package:stufund/pages/getStartedPage.dart';
import 'package:stufund/pages/onBoardingScreen.dart';
import 'data/colors.dart';
import 'pages/authenticationPages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(const MyApp());
}



Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    print('An error occurred configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
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
            foregroundColor: AppColors.text,
            backgroundColor: AppColors.primary,
          ),
        ),
      ),
      home: FutureBuilder<bool>(
      future: loginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          bool isLoggedIn = snapshot.data ?? false;
          if (isLoggedIn) {
            return HomePage();
          } else {
            return screenWidth >= 800 ? GetStarted() : OnBoardingScreen();
          }
        }
      },
    ),
    );
  }
}

Future<bool> loginStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String key = 'isLoggedIn';
  if (prefs.containsKey(key)) {
    return prefs.getBool(key) ?? false;
  } else {
    await prefs.setBool(key, false);
    return false;
  }
}

