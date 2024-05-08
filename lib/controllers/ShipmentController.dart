import 'package:siuntu_web_app/services/ShipmentService.dart' as shipmentService;
import 'package:siuntu_web_app/models/Shipment.dart';
import 'package:siuntu_web_app/models/Package.dart';
import 'dart:convert';

class ShipmentController {
  Future<List<Shipment>> getShipments() async {
    return await shipmentService.getShipments();
  }

  Future<bool> registerShipment(Shipment shipment) async {
    return await shipmentService.createShipment(shipment);
  }

  Future<List<Package>> getPackages() async {
    return await shipmentService.getPackages();
  }
}
