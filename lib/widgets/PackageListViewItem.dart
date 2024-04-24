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
import 'package:siuntu_web_app/models/Shipment.dart';
//create hero widget

class PackageListViewItem extends StatelessWidget {
  String formatTime(String time) {
    DateTime parsedTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd  kk:mm').format(parsedTime);
  }

  //todo move to utils
  Future<Uint8List> createQrImage(String data) async {
    final qrCode = QrPainter(
      data: data,
      version: QrVersions.auto,
    );
    final image = await qrCode.toImage(100);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  //Todo move to utils
  Future<void> createPdf(Shipment shipment) async {
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(530, 100, marginAll: 10),
        build: (pw.Context context) => pw.Center(
          child: pw.Container(
            child: pw.Row(children: [
              pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data: shipment.id.toString(),
                width: 80,
                height: 100,
              ),
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
                    child: pw.Text('${shipment.recieverName}',
                        style: pw.TextStyle(font: font))),
                pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    width: 200,
                    child: pw.Text('${shipment.recieverCity}',
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
                    child: pw.Text('${shipment.senderName}',
                        style: pw.TextStyle(font: font))),
                pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    width: 200,
                    child: pw.Text('${shipment.senderCity}',
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
              'Gavėjas: ${shipment.recieverName} | ${shipment.recieverCity}'),
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
                                          title: Text('Siuntos Nr.'),
                                          subtitle:
                                              Text(shipment.id.toString()),
                                        ),
                                        //combine sender fields into one
                                        ListTile(
                                          title: Text('Siuntėjas'),
                                          subtitle: Text(
                                              '${shipment.senderName} | ${shipment.senderCity}'),
                                        ),
                                        //combine receiver fields into one
                                        ListTile(
                                          title: Text('Gavėjas'),
                                          subtitle: Text(
                                              '${shipment.recieverName} | ${shipment.recieverCity}'),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            shipment.shipmentStatuses?.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(shipment
                                                .shipmentStatuses![index].name
                                                .toString()),
                                            subtitle: Text(formatTime(shipment
                                                .shipmentStatuses![index]
                                                .createdAt
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
                  },
                  icon: new Icon(Icons.zoom_in)),
              // if (shipment.shipmentType == 'SELF_PACK')
                new IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                            builder: (BuildContext context) {
                          //todo move to separate widget
                          return Scaffold(
                            appBar:
                                AppBar(title: const Text('Siuntos QR Kodas')),
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
                    },
                    icon: new Icon(Icons.qr_code_outlined)),
              // if (shipment.shipmentType == 'SELF_SERVICE')
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
}
