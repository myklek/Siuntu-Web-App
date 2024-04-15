import 'package:siuntu_web_app/models/Shipment.dart';
import 'dart:convert';

void main() {
  Shipment shipment = Shipment(
    id: 1,
  );

  print(jsonEncode(shipment));

}