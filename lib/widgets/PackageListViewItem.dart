import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:html' as webFile;
import 'package:printing/printing.dart';

//create hero widget



class PackageListViewItem extends StatelessWidget {

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
                    child: pw.Text('Gavėjas',
                        style: pw.TextStyle(font: font))),
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
                    child: pw.Text('Siuntėjas',
                        style: pw.TextStyle(font: font))),
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
                          appBar: AppBar(title: const Text('Siuntos QR Kodas')),
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
