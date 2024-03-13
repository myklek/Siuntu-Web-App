import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> login(String email, String password) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse('http://localhost:8080/auth/login'),
    headers: <String, String>{
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
    print(response.body);
    print(decodedToken);
    // Save token to shared preferences
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', token);
    return true;
  } else {
    return false;
  }
}
