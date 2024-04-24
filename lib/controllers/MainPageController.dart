import 'package:flutter/material.dart';
import 'package:siuntu_web_app/controllers/ShipmentController.dart';
import 'package:siuntu_web_app/pages/RegisterPackagePage.dart';
import 'package:siuntu_web_app/models/Shipment.dart';


class MainPageController {
  final ShipmentController _shipmentController = ShipmentController();

  Future<List<Shipment>> fetchShipments() async {
    return await _shipmentController.fetchShipments();
  }

  void navigateToShipmentCreation(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateShipmentPage()));
  }
}