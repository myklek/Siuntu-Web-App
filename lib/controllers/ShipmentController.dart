import 'package:siuntu_web_app/services/shipments.dart';
import 'package:siuntu_web_app/models/Shipment.dart';
import 'package:siuntu_web_app/models/Package.dart';
import 'dart:convert';

class ShipmentController {
  Future<List<Shipment>> fetchShipments() async {
    return await getShipments();

  }

  Future<bool> registerShipment(Shipment shipment) async {
    return await createShipment(shipment);
  }

  Future<List<Package>> fetchPackages() async {
    return await getPackages();
  }
}
