import 'package:siuntu_web_app/models/Package.dart';
import 'package:siuntu_web_app/models/Status.dart';

class Shipment {
  List<Status>? shipmentStatuses;
  String? senderName;
  String? senderAddress;
  String? senderPhoneNumber;
  String? recieverName;
  String? recieverAddress;
  String? recieverPhoneNumber;
  String? createdAt;
  String? updatedAt;
  String? shipmentType;
  bool? collected;
  Package? package;
  int? id;

  Shipment(
      {this.shipmentStatuses,
      this.senderName,
      this.senderAddress,
      this.senderPhoneNumber,
      this.recieverName,
      this.recieverAddress,
      this.recieverPhoneNumber,
      this.createdAt,
      this.updatedAt,
      this.shipmentType,
      this.collected,
      this.package,
      this.id});

  Shipment.fromJson(Map<String, dynamic> json) {
    if (json['shipmentStatuses'] != null) {
      shipmentStatuses = <Status>[];
      json['shipmentStatuses'].forEach((v) {
        shipmentStatuses!.add(new Status.fromJson(v));
      });
    }
    senderName = json['senderName'];
    senderAddress = json['senderAddress'];
    senderPhoneNumber = json['senderPhoneNumber'];
    recieverName = json['recieverName'];
    recieverAddress = json['recieverAddress'];
    recieverPhoneNumber = json['recieverPhoneNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    shipmentType = json['shipmentType'];
    collected = json['collected'];
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
    data['senderAddress'] = this.senderAddress;
    data['senderPhoneNumber'] = this.senderPhoneNumber;
    data['recieverName'] = this.recieverName;
    data['recieverAddress'] = this.recieverAddress;
    data['recieverPhoneNumber'] = this.recieverPhoneNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['shipmentType'] = this.shipmentType;
    data['collected'] = this.collected;
    data['package'] = this.package;
    data['id'] = this.id;
    return data;
  }
}
