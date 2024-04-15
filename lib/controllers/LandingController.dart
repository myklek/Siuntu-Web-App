import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/LoginPage.dart';
import 'package:siuntu_web_app/pages/RegisterPage.dart';

class LandingController {
  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }
}