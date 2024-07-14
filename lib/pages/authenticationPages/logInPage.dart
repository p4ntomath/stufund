// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufund/pages/HomePage.dart';
import 'package:stufund/pages/authenticationPages/forgotPassword.dart';
import 'package:stufund/pages/authenticationPages/userSessionManager.dart';
import '../../data/colors.dart';
import 'SignUpPage.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;


@override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor:AppColors.primary ,
        ),
        backgroundColor: AppColors.primary,
        body:SingleChildScrollView(  // Added SingleChildScrollView here
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
                          'Log In',
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.email_outlined,
                                color: AppColors.background,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.secondary,
                            labelStyle: TextStyle(
                              color: Colors.black87,
                            ),
                            labelText: 'Email',
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
                          validator: validateEmail,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.background,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.secondary,
                            labelStyle: TextStyle(
                              color: Colors.black87,
                            ),
                            labelText: 'Password',
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
                          validator: validatePassword,
                        ),
                        SizedBox(height: 5,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: (){
                              Navigator.push( context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                              );
                            },
                            child: Text('Forgot Password?',
                            style: TextStyle(
                              color: AppColors.text
                            ),)
                            )
                            ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if(formKey.currentState!.validate()){
                              UserSessionManager userSessionManager = UserSessionManager();
                              String email = emailController.text;
                              String password = passwordController.text;
                              if(await userSessionManager.loginUser(email, password,context)){
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                String key = 'isLoggedIn';
                                prefs.setBool(key, true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColors.background,
                                    content: Text('Log In Success',
                                    style: TextStyle(
                                      color: AppColors.text
                                    ),),
                                  ),
                                );
                                Navigator.push( context,
                                MaterialPageRoute(builder: (context) => HomePage()));
      
                              }
                            }
      
                          },
                          child: Text('Log In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.text
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                            backgroundColor: AppColors.secondary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: (){
                          Navigator.push( context,
                                MaterialPageRoute(builder: (context) => SignUpPage()),
                              );
                        },
                      child: Text("Sign Up",
                        style:TextStyle(
                          color: Color.fromARGB(255, 76, 80, 209)
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        
      );
  }

  String? validateEmail(String? value) {
    String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must contain at least 8 characters';
    }
    return null;
  }
}
