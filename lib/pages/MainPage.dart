import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/RegisterPackagePage.dart';
import 'package:siuntu_web_app/controllers/ShipmentController.dart';
import 'package:siuntu_web_app/models/Shipment.dart';
import 'package:siuntu_web_app/widgets/PackageListViewItem.dart';
import 'package:flutter/material.dart';
import 'package:siuntu_web_app/controllers/MainPageController.dart';
import 'package:siuntu_web_app/widgets/PackageListViewItem.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Shipment> shipments = [];
  final MainPageController _mainPageController = MainPageController();

  @override
  void initState() {
    super.initState();
    fetchShipments();
  }

  void fetchShipments() async {
    List<Shipment> data = await _mainPageController.fetchShipments();
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mainPageController.navigateToShipmentCreation(context);
        },
        child: const Icon(Icons.add_to_photos_outlined),
      ),
    );
  }
}