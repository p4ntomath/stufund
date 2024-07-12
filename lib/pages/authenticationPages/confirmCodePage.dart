// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufund/pages/HomePage.dart';
import 'package:stufund/pages/authenticationPages/userSessionManager.dart';
import '../../data/colors.dart';

class ConfirmCodePage extends StatefulWidget {
  final String email;

  const ConfirmCodePage({Key? key, required this.email}) : super(key: key);

  @override
  _ConfirmCodePageState createState() => _ConfirmCodePageState();
}

class _ConfirmCodePageState extends State<ConfirmCodePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController comfirmContoller = TextEditingController();
  UserSessionManager userSessionManager = UserSessionManager();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                'Email: ${widget.email}',
                style: GoogleFonts.lato(
                  color: AppColors.text,
                ),
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
                      TextFormField(
                        controller: comfirmContoller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.lock_outline,
                              color: AppColors.background,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.secondary,
                          labelStyle: TextStyle(
                            color: Colors.black87,
                          ),
                          labelText: 'Enter Code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.button,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: validateCode,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if(await userSessionManager.confirmUser(
                                widget.email, comfirmContoller.text.trim(),context)){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Email Comfirmed'),
                                      ),
                                    );
                                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                                    String key = 'isLoggedIn';
                                    prefs.setBool(key, true);
                                    Navigator.push( context,
                                      MaterialPageRoute(builder: (context) => HomePage()));

                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Something Went Wrong,Try Again'),
                                      ),
                                    );
                                }
                          }
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
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
                      if(await userSessionManager.resendConfirmationCode(widget.email,context)){
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
