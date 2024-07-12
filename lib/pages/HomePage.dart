// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufund/pages/authenticationPages/userSessionManager.dart';
import 'package:stufund/pages/getStartedPage.dart';
import 'package:stufund/pages/onBoardingScreen.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  UserSessionManager userSessionManager = UserSessionManager();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed:() async {

          if(await userSessionManager.signOutUser(context)){
          Widget destination = screenWidth >= 800 ? GetStarted() : OnBoardingScreen();
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          String key = 'isLoggedIn';
          prefs.setBool(key, false);
          Navigator.push( context,
                              MaterialPageRoute(builder: (context) => destination));
          }

        }, child: Text('Sign Out',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),)
        ,style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
        ),),
      ),
    );
  }
}