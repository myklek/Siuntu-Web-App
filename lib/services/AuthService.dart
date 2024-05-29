import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siuntu_web_app/utils/consts.dart' as consts;

Future<bool> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://' + consts.ip + '/auth/login'),
    headers: <String, String>{
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    await saveUserDataToLocalStorage(data);
    return true;
  } else {
    return false;
  }
}

Future<void> saveUserDataToLocalStorage(Map<String, dynamic> data) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.setString('token', data['token']);
  prefs.setInt('userId', data['userId']);
}

Future<bool> register(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://' + consts.ip + '/auth/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
