import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/RegisterPage.dart';
import 'package:siuntu_web_app/pages/RegisterPackagePage.dart';
import 'package:siuntu_web_app/services/shipments.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:siuntu_web_app/widgets/PackageListViewItem.dart';

// Create register page with email, password and repeat password fields and register button
class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<dynamic> shipments = [];

  @override
  void initState() {
    super.initState();
    fetchShipments(); // Call fetchShipments on widget initialization
  }

  void fetchShipments() async {
    List<dynamic> data = await getShipments(); // Call getShipments function
    setState(() {
      print(data);
      shipments = data; // Fill list with records
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
            return PackageListViewItem(shipments: shipments[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterPackagePage()));
          },
          child: const Icon(Icons.add_to_photos_outlined),
        ));
  }
}
