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
                  child: pw.Text('${shipment.recieverAddress}',
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
                  child: pw.Text('${shipment.recieverAddress}',
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