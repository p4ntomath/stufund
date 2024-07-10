import 'package:flutter/material.dart';
import '../data/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authenticationPages/LogInDialog.dart';
import 'authenticationPages/SignUpDialog.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return  Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Main content
            Expanded(
              child: Center(
                child:Image.asset('assets/images/applogo.png',
                width: (screenWidth*0.6),)
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text("Welcome",
              style: GoogleFonts.lato(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),),),
            // Bottom buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: (screenHeight*0.1)),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ensure the column only takes necessary space
                  children: [
                    SizedBox(
                      width:(screenWidth*0.8),
                      height: (screenHeight*0.065),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          LogInDialog(context);
                        },
                        child: Text("Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),),
                      ),
                    ),
                    SizedBox(height: 20), // Adjust spacing as needed
                    SizedBox(
                      width: (screenWidth*0.8),
                      height: (screenHeight*0.065),
                      child: ElevatedButton(
                        onPressed: () {
                          SignUpDialog(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 2.0, color: Colors.black),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: AppColors.background,
                          // Set border width and color
                        ),
                        child: Text("Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
