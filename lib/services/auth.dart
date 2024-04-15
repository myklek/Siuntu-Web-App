import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siuntu_web_app/utils/consts.dart' as consts;

Future<bool> login(String email, String password) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse('http://' + consts.ip + ':8080/auth/login'),
    headers: <String, String>{
      'Access-Control-Allow-Private-Network': 'true',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String token = data['token'];
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    debugPrint(response.body);
    // debugPrint(decodedToken as String?);
    // Save token to shared preferences
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', data['token']);
    prefs.setInt('userId', data['userId']);
    return true;
  } else {
    debugPrint(response.body);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://' + consts.ip + ':8080/auth/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  // debugPrint(response as String?);
  if (response.statusCode == 200) {
    return true;
  } else {
    // debugPrint(response as String?);
    debugPrint(response.body);
    return false;
  }
}
