import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/MainView.dart';
import 'package:siuntu_web_app/services/AuthService.dart' as auth;
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AuthenticationController {
  Future<bool> login(String email, String password) async {
    return await auth.login(email,password);
  }
  Future<bool> register(String email, String password) async {
    return auth.register(
      email,
      password,
    );
  }
}
