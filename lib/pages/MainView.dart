import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/CreateShipmentView.dart';
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
    List<Shipment> data = await _shipmentController.getShipments();
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
      body: shipments.length > 0
          ? ListView.builder(
              itemCount: shipments.length,
              itemBuilder: (context, index) {
                return PackageListViewItem(shipment: shipments[index]);
              },
            )
          : Center(
              child: Text(
              "Siuntų sąrašas tuščias",
              style: TextStyle(fontSize: 20),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToCreateShipmentView(context);
        },
        child: const Icon(Icons.add_to_photos_outlined),
      ),
    );
  }

  void navigateToCreateShipmentView(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateShipmentView()));
  }
}
