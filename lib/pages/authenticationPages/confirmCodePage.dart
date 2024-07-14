// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufund/pages/HomePage.dart';
import 'package:stufund/pages/authenticationPages/userSessionManager.dart';
import '../../data/colors.dart';

class ConfirmCodePage extends StatefulWidget {
  final String email;

  const ConfirmCodePage({super.key, required this.email});

  @override
  _ConfirmCodePageState createState() => _ConfirmCodePageState();
}

class _ConfirmCodePageState extends State<ConfirmCodePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController confirmController = TextEditingController();
  UserSessionManager userSessionManager = UserSessionManager();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 100,
                    maxWidth: 300,
                  ),
                  child: Image.asset(
                    'assets/images/applogo.png',
                    width: (screenWidth * 0.6),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Code sent to : \n ${widget.email}',
                style: GoogleFonts.lato(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                  maxWidth: 300,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Confirm Code',
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        controller: confirmController,
                        validator: validateCode,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => print(pin),
                        focusedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.button),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        submittedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.text,
                            ),
                          ),
                        ),
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (await userSessionManager.confirmUser(
                                widget.email,
                                confirmController.text.trim(),
                                context)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Email Confirmed'),
                                ),
                              );
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              String key = 'isLoggedIn';
                              prefs.setBool(key, true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Something Went Wrong, Try Again'),
                                ),
                              );
                            }
                          }
                        },
                        child: Text('Confirm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          backgroundColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive a code? "),
                  GestureDetector(
                    onTap: () async {
                      if (await userSessionManager.resendConfirmationCode(widget.email, context)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Code Sent'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                          color: Color.fromARGB(255, 76, 80, 209)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Code is required';
    } else if (value.length != 6) {
      return 'Code must be 6 digits';
    } else if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
      return 'Code must be a number';
    }
    return null;
  }
}
