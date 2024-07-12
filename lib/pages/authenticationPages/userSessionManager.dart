// ignore_for_file: unrelated_type_equality_checks, unnecessary_import, unused_local_variable, use_build_context_synchronously

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:stufund/data/colors.dart';

class UserSessionManager {
  Future<bool> signUpUser(String email, String password, String preferredUsername,BuildContext context) async {
  showDialog(context:context
        ,builder: (context) {
        return Center(child: CircularProgressIndicator());
                            });
  try {
    SignUpResult result = await Amplify.Auth.signUp(
      username: email.trim(),
      password: password.trim(),
      options: SignUpOptions(
        userAttributes: {
          CognitoUserAttributeKey.email: email.trim(),
          CognitoUserAttributeKey.preferredUsername: preferredUsername.trim(),
        },
      ),
    );

    // Check the next step in the sign-up process
    if (result.userId!.isNotEmpty) {
      Navigator.of(context).pop();
      return true; // Confirmation code needs to be entered
    }else {
      Navigator.of(context).pop();
      return false; // Sign up is complete
    }
  } on AuthException catch (e) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.background,
        content: Text('Error signing up: ${e.message}',
        style: TextStyle(
          color: AppColors.text
        ),),
      ),
    );
    return false;
  }
}
  Future<bool> confirmUser(String email, String confirmationCode,BuildContext context) async {
    showDialog(context:context
        ,builder: (context) {
        return Center(child: CircularProgressIndicator());
                            });
    try {
      SignUpResult result = await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: confirmationCode,
      );
      Navigator.of(context).pop();
      return result.isSignUpComplete;
    } on AuthException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.background,
        content: Text('Error signing up: ${e.message}',
        style: TextStyle(
          color: AppColors.text
        ),),
      ),
    );
      return false;
    }
  }

  Future<bool> loginUser(String email, String password,BuildContext context) async {
    showDialog(context:context
        ,builder: (context) {
        return Center(child: CircularProgressIndicator());
                            });
    try {
      SignInResult result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      Navigator.of(context).pop();
      return true;
    } on AuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.background,
        content: Text('Error signing up: ${e.message}',
        style: TextStyle(
          color: AppColors.text
        ),),
      ),
    );
      Navigator.of(context).pop();
      return false;
    }
  }

  Future<bool> signOutUser(BuildContext context) async {
        showDialog(context:context
        ,builder: (context) {
        return Center(child: CircularProgressIndicator());
                            });
    try {
      await Amplify.Auth.signOut();
      Navigator.of(context).pop();
      return true;
    } on AuthException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.background,
        content: Text('Error signing up: ${e.message}',
        style: TextStyle(
          color: AppColors.text
        ),),
      ),
    );
      return false;
    }
  }

  Future<bool> resendConfirmationCode(String email,BuildContext context) async {
    try {
      ResendSignUpCodeResult result = await Amplify.Auth.resendSignUpCode(
        username: email,
      );
      print('Resend code successful: ${result.codeDeliveryDetails.destination}');
      return true;
    } on AuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.background,
              content: Text('Error signing up: ${e.message}',
              style: TextStyle(
                color: AppColors.text
              ),),
            ),
    );
      return false;
    }
  }

  Future<bool> resetPassword(String email,BuildContext context) async {
    try {
      ResetPasswordResult result = await Amplify.Auth.resetPassword(
        username: email,
      );
    return true;
    } on AuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.background,
              content: Text('Error signing up: ${e.message}',
              style: TextStyle(
                color: AppColors.text
              ),),
            ),
    );
    return false;
    }
  }

  Future<bool> confirmResetPassword(String email, String newPassword, String confirmationCode,BuildContext context) async {
      showDialog(context:context
        ,builder: (context) {
        return Center(child: CircularProgressIndicator());
                            });
    try {
      await Amplify.Auth.confirmResetPassword(
        username: email,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      Navigator.of(context).pop();
      return true;
    } on AuthException catch (e) {
      Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.background,
              content: Text('Error signing up: ${e.message}',
              style: TextStyle(
                color: AppColors.text
              ),),
            ),
    );
      return false;
    }
  }
}
