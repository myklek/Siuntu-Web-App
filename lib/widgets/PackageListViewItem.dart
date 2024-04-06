import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:html' as webFile;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import 'package:progress_stepper/progress_stepper.dart';
//create hero widget

class PackageListViewItem extends StatelessWidget {
  String formatTime(String time) {
    DateTime parsedTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd  kk:mm').format(parsedTime);
  }

  Future<Uint8List> createQrImage(String data) async {
    final qrCode = QrPainter(
      data: data,
      version: QrVersions.auto,
    );
    final image = await qrCode.toImage(100);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> createPdf(dynamic shipment) async {
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final pdf = pw.Document();

    pw.Image qrImage = pw.Image(
        pw.MemoryImage(await createQrImage(shipment['id'].toString())));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(530, 100, marginAll: 10),
        build: (pw.Context context) => pw.Center(
          child: pw.Container(
            child: pw.Row(children: [
              qrImage,
              pw.VerticalDivider(),
              pw.Column(children: [
                pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    width: 200,
                    child: pw.Text('Gavėjas', style: pw.TextStyle(font: font))),
                pw.Container(child: pw.Divider(), width: 200),
                pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    width: 200,
                    child: pw.Text('${shipment['recieverName']}',
                        style: pw.TextStyle(font: font))),
                pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    width: 200,
                    child: pw.Text('${shipment['recieverCity']}',
                        style: pw.TextStyle(font: font))),
              ]),
              pw.VerticalDivider(),
              pw.Column(children: [
                pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    width: 200,
                    child:
                        pw.Text('Siuntėjas', style: pw.TextStyle(font: font))),
                pw.Container(child: pw.Divider(), width: 200),
                pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    width: 200,
                    child: pw.Text('${shipment['senderName']}',
                        style: pw.TextStyle(font: font))),
                pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    width: 200,
                    child: pw.Text('${shipment['senderCity']}',
                        style: pw.TextStyle(font: font))),
              ]),
            ]),
          ),
        ),
      ),
    );

    var savedFile = await pdf.save();
    List<int> fileInts = List.from(savedFile);
    webFile.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
      ..click();
  }

  final Map<String, dynamic> shipments;

  const PackageListViewItem({Key? key, required this.shipments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> possibleStatuses = [
      'LABEL_CREATED',
      'COLLECTED',
      'IN_DELIVERY'
    ];

    // Find the current status of the shipment
    String currentStatus = shipments['shipmentStatuses'].last['name'];

    // Determine the current step based on the current status
    int currentStep = possibleStatuses.indexOf(currentStatus);

    // Calculate the progress value
    double progressValue = (currentStep + 1) / possibleStatuses.length;

    return Hero(
      tag: 'ListTile-Hero ${shipments['id']}',
      child: Material(
        child: ListTile(
          title: new Text('Siuntos Nr. ${shipments['id']}'),
          subtitle: new Text(
              'Gavėjas: ${shipments['recieverName']} | ${shipments['recieverCity']}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                          builder: (BuildContext context) {
                        return Scaffold(
                            appBar: AppBar(
                                title: const Text('Platesnė informacija')),
                            body: Column(
                              children: [
                                ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('Siuntos Nr.'),
                                      subtitle:
                                          Text(shipments['id'].toString()),
                                    ),
                                    //combine sender fields into one
                                    ListTile(
                                      title: Text('Siuntėjas'),
                                      subtitle: Text(
                                          '${shipments['senderName']} | ${shipments['senderCity']}'),
                                    ),
                                    //combine receiver fields into one
                                    ListTile(
                                      title: Text('Gavėjas'),
                                      subtitle: Text(
                                          '${shipments['recieverName']} | ${shipments['recieverCity']}'),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        shipments['shipmentStatuses'].length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                            shipments['shipmentStatuses'][index]
                                                ['name']),
                                        subtitle: Text(formatTime(
                                            shipments['shipmentStatuses'][index]
                                                    ['createdAt']
                                                .toString())),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ));
                      }),
                    );
                  },
                  icon: new Icon(Icons.zoom_in)),
              if (shipments['shipmentType'] == 'SELF_PACK' && shipments['collected'] == false)
                new IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                            builder: (BuildContext context) {
                          return Scaffold(
                            appBar:
                                AppBar(title: const Text('Siuntos QR Kodas')),
                            body: Center(
                              child: Hero(
                                tag: 'ListTile-Hero ${shipments['id']}',
                                child: Material(
                                  child: QrImageView(
                                    data: shipments['id'].toString(),
                                    version: QrVersions.auto,
                                    size: 300.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    icon: new Icon(Icons.qr_code_outlined)),
              if (shipments['shipmentType'] == 'SELF_SERVICE')
                new IconButton(
                  onPressed: () {
                    createPdf(shipments);
                  },
                  icon: new Icon(Icons.file_copy_outlined))
            ],
          ),
          tileColor: Colors.grey[200],
        ),
      ),
    );
  }
}
