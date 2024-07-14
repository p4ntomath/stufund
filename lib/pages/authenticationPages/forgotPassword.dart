// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stufund/pages/authenticationPages/logInPage.dart';
import 'package:stufund/pages/authenticationPages/userSessionManager.dart';
import '../../data/colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isCodeSent = false;
  bool _passwordVisible = false; // Track password visibility
  UserSessionManager userSessionManager = UserSessionManager();

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
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
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        _isCodeSent ? 'Confirm Code' : 'Forgot Password',
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.secondary,
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
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 20),
                      if (_isCodeSent)
                        Column(
                          children: [
                            TextFormField(
                              controller: _codeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: AppColors.background,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                filled: true,
                                fillColor: AppColors.secondary,
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
                              validator: _validateCode,
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: !_passwordVisible, // Toggle visibility based on _passwordVisible
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: AppColors.background,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible; // Toggle visibility
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: AppColors.secondary,
                                labelText: 'New Password',
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
                              validator: _validatePassword,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _confirmCode(context);
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
                            SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                _sendCode(context);
                              },
                              child: Text(
                                'Resend Code',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 76, 80, 209),
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (!_isCodeSent)
                        ElevatedButton(
                          onPressed: () {
                            _sendCode(context);
                          },
                          child: Text(
                            'Send Code',
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
                  Text("Remembered your password? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInPage()),
                      ); // Navigate back to Log In page
                    },
                    child: Text(
                      "Log In",
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
    );
  }

  String? _validateEmail(String? value) {
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

  String? _validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Code is required';
    } else if (value.length != 6) {
      return 'Code must be 6 digits';
    } else if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
      return 'Code must be a number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  Future<void> _sendCode(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      if (await userSessionManager.resetPassword(email, context)) {
        setState(() {
          _isCodeSent = true;
        });
      }
    }
  }

  Future<void> _confirmCode(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String code = _codeController.text;
      String newPassword = _newPasswordController.text;
      if (await userSessionManager.confirmResetPassword(
          email, newPassword, code, context)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('password reset successful'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogInPage()),
        );
      }
    }
  }
}
