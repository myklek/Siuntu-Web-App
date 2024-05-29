import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siuntu_web_app/models/Package.dart';
import 'package:siuntu_web_app/models/Shipment.dart';
import 'package:siuntu_web_app/utils/consts.dart' as consts;

Future<List<Shipment>> getShipments() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final String? token = prefs.getString('token');
  final response = await http.get(
    Uri.parse('http://' + consts.ip + ':8080/api/shipment/all'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    final String decodedBody = utf8.decode(response.bodyBytes);
    final List<dynamic> data = jsonDecode(decodedBody);
    return data.map((item) => Shipment.fromJson(item)).toList();
  } else {
    return [];
  }
}

Future<bool> createShipment(Shipment shipment) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final String? token = prefs.getString('token');
  final response = await http.post(
      Uri.parse('http://' + consts.ip + ':8080/api/shipment/new'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(shipment));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<Package>> getPackages() async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final String? token = prefs.getString('token');
  final response = await http.get(
    Uri.parse('http://' + consts.ip + ':8080/api/shipment/packages'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    final String decodedBody = utf8.decode(response.bodyBytes);
    final List<dynamic> data = jsonDecode(decodedBody);
    return data.map((item) => Package.fromJson(item)).toList();
  } else {
    return [];
  }
}
