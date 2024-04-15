import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/RegisterPackagePage.dart';
import 'package:siuntu_web_app/controllers/ShipmentController.dart';
import 'package:siuntu_web_app/models/Shipment.dart';
import 'package:siuntu_web_app/widgets/PackageListViewItem.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Shipment> shipments = [];
  final ShipmentController _shipmentController = ShipmentController();

  @override
  void initState() {
    super.initState();
    fetchShipments();
  }

  void fetchShipments() async {
    List<Shipment> data = await _shipmentController.fetchShipments();
    setState(() {
      shipments = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Siuntos'),
      ),
      body: ListView.builder(
        itemCount: shipments.length,
        itemBuilder: (context, index) {
          return PackageListViewItem(shipment: shipments[index]);
          // return Text('placeholder');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPackagePage()));
        },
        child: const Icon(Icons.add_to_photos_outlined),
      ),
    );
  }
}