import 'package:flutter/material.dart';
import 'package:siuntu_web_app/services/shipments.dart';
import 'package:qr_flutter/qr_flutter.dart';

//create hero widget
class PackageListViewItem extends StatelessWidget {
  final Map<String, dynamic> shipments;

  const PackageListViewItem({Key? key, required this.shipments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'ListTile-Hero',
      child: Material(
        child: ListTile(
          title: new Text('Siuntos Nr. ${shipments['id']}'),
          subtitle: new Text('Gavėjas: ${shipments['recieverName']} | ${shipments['recieverCity']}'),
          trailing: new Icon(Icons.qr_code_rounded),
          tileColor: Colors.grey[200],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(title: const Text('Siuntos QR Kodas')),
                  body: Center(
                    child: Hero(
                      tag: 'ListTile-Hero',
                      child: Material(
                        child: QrImageView(
                          data: shipments['id'].toString(),
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}