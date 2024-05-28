import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:siuntu_web_app/models/Shipment.dart';
import 'package:siuntu_web_app/utils/pdf.dart';

class PackageListViewItem extends StatelessWidget {
  String formatTime(String time) {
    DateTime parsedTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd  kk:mm').format(parsedTime);
  }

  final Shipment shipment;

  const PackageListViewItem({Key? key, required this.shipment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'ListTile-Hero ${shipment.id}',
      child: Material(
        child: ListTile(
          title: new Text('Siuntos Nr. ${shipment.id}'),
          subtitle: new Text(
              'Gavėjas: ${shipment.recieverName} | ${shipment.recieverAddress}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new IconButton(
                  onPressed: () {
                    showMoreInformation(context);
                  },
                  icon: new Icon(Icons.zoom_in)),
              if (shipment.shipmentType == 'SELF_SERVICE' &&
                  shipment.collected == false)
                new IconButton(
                    onPressed: () {
                      showQRCode(context);
                    },
                    icon: new Icon(Icons.qr_code_outlined)),
              if (shipment.shipmentType == 'SELF_PACK' &&
                  shipment.collected == false)
                new IconButton(
                    onPressed: () {
                      createPdf(shipment);
                    },
                    icon: new Icon(Icons.file_copy_outlined))
            ],
          ),
        ),
      ),
    );
  }

  void showQRCode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Siuntos QR Kodas')),
          body: Center(
            child: Hero(
              tag: 'ListTile-Hero ${shipment.id}',
              child: Material(
                child: QrImageView(
                  data: shipment.id.toString(),
                  version: QrVersions.auto,
                  size: 300.0,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void showMoreInformation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Detalesnė informacija')),
            body: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ListTile(
                          title: Text('Siuntos Numeris'),
                          subtitle: Text(shipment.id.toString()),
                        ),
                        ListTile(
                          title: Text('Siuntėjas'),
                          subtitle: Text(
                              '${shipment.senderName} | ${shipment.recieverAddress}'),
                        ),
                        ListTile(
                          title: Text('Gavėjas'),
                          subtitle: Text(
                              '${shipment.recieverName} | ${shipment.recieverAddress}'),
                        ),
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: shipment.shipmentStatuses?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(shipment.shipmentStatuses![index].name
                                .toString()),
                            subtitle: Text(formatTime(shipment
                                .shipmentStatuses![index].createdAt
                                .toString())),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
