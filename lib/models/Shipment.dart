import 'package:siuntu_web_app/models/Package.dart';

class Shipment {
  List<ShipmentStatuses>? shipmentStatuses;
  String? senderName;
  String? senderCity;
  String? recieverName;
  String? recieverCity;
  String? createdAt;
  String? updatedAt;
  String? shipmentType;
  Package? package;
  int? id;

  Shipment(
      {this.shipmentStatuses,
      this.senderName,
      this.senderCity,
      this.recieverName,
      this.recieverCity,
      this.createdAt,
      this.updatedAt,
      this.shipmentType,
      this.package,
      this.id});

  Shipment.fromJson(Map<String, dynamic> json) {
    if (json['shipmentStatuses'] != null) {
      shipmentStatuses = <ShipmentStatuses>[];
      json['shipmentStatuses'].forEach((v) {
        shipmentStatuses!.add(new ShipmentStatuses.fromJson(v));
      });
    }
    senderName = json['senderName'];
    senderCity = json['senderCity'];
    recieverName = json['recieverName'];
    recieverCity = json['recieverCity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    shipmentType = json['shipmentType'];
    package = json['package'] != null ? new Package.fromJson(json['package']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shipmentStatuses != null) {
      data['shipmentStatuses'] =
          this.shipmentStatuses!.map((v) => v.toJson()).toList();
    }
    data['senderName'] = this.senderName;
    data['senderCity'] = this.senderCity;
    data['recieverName'] = this.recieverName;
    data['recieverCity'] = this.recieverCity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['shipmentType'] = this.shipmentType;
    data['package'] = this.package;
    data['id'] = this.id;
    return data;
  }
}

class ShipmentStatuses {
  String? createdAt;
  String? name;

  ShipmentStatuses({this.createdAt, this.name});

  ShipmentStatuses.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }
}
