// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/colors.dart';
import 'LogInDialog.dart';

void SignUpDialog(BuildContext context) {
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Animate(
            effects: [FadeEffect(), ScaleEffect()],
            child: Dialog(
              backgroundColor: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: AppColors.text,
                            ),
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusColor: AppColors.background,
                            suffixIcon: Icon(
                              Icons.person,
                              size: 20,
                              color: AppColors.primary,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required';
                            }else if(value.length < 3){
                              return 'Username too short';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: AppColors.text,
                            ),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusColor: AppColors.background,
                            suffixIcon: Icon(
                              Icons.email,
                              size: 20,
                              color: AppColors.primary,
                            ),
                          ),
                          validator: validateEmail,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: validatePassword,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: AppColors.text,
                            ),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusColor: AppColors.background,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // todo: Implement sign up functionality
                            }
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 19,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            backgroundColor: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                LogInDialog(context);
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  String pattern =
      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}
