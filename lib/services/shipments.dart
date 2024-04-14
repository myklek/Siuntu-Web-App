import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siuntu_web_app/utils/consts.dart' as consts;

Future<List<dynamic>> getShipments() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final String? token = prefs.getString('token');
  final response = await http.get(
    Uri.parse('http://' + consts.ip + ':8080/api/shipments'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    final String decodedBody = utf8.decode(response.bodyBytes);
    final List<dynamic> data = jsonDecode(decodedBody);

    return data;
  } else {
    print(response.body);
    return [];
  }
}

Future<bool> registerShipment(
   dynamic shipment) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final String? token = prefs.getString('token');
  final int? userId = prefs.getInt('userId');
  final response = await http.post(
    Uri.parse('http://' + consts.ip + ':8080/api/shipments/new'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: shipment);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
