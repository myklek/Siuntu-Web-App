import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:siuntu_web_app/widgets/ShipmentSizeDropdown.dart';
import 'package:siuntu_web_app/widgets/ShipmentTypeRadioGroup.dart';
import 'package:siuntu_web_app/pages/MainPage.dart'; // Import MainPage
import 'package:siuntu_web_app/controllers/ShipmentController.dart';
import 'package:siuntu_web_app/models/Shipment.dart';


import 'MainPage.dart';


final _formKey = GlobalKey<FormBuilderState>();
List<String> packageOptions = [
  'S - iki 0.5kg 10/10/10 cm',
  'M - iki 2kg 20/20/20 cm',
  'L - iki 5kg 30/30/30 cm'
];


class RegisterPackagePage extends StatefulWidget {
  @override
  State<RegisterPackagePage> createState() => _RegisterPackagePageState();
}

class _RegisterPackagePageState extends State<RegisterPackagePage> {
  bool isSelfPack = false;
  final ShipmentController _shipmentController = ShipmentController();

  List<Widget> forms = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'senderName',
        decoration: const InputDecoration(labelText: 'Siuntėjo vardas',border: OutlineInputBorder()),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'senderCity',
        decoration: const InputDecoration(labelText: 'Siuntėjo miestas',border: OutlineInputBorder(),),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    ),
    Divider(color: Colors.white, height: 20),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'recieverName',
        decoration: const InputDecoration(labelText: 'Gavėjo Vardas',border: OutlineInputBorder()),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'recieverCity',
        decoration: const InputDecoration(labelText: 'Gavėjo miestas',border: OutlineInputBorder()),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Užregistruoti siuntą'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                ...forms,
                ShipmentTypeRadioGroup(
                    callback: (value) => setState(() => isSelfPack = value)),
                if (isSelfPack) ShipmentSizeDropdown(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      child: const Text('Sukurti naują siuntą'),
                      onPressed: () async {
                        if (_formKey.currentState?.saveAndValidate() == true) {
                          print(_formKey.currentState?.value.toString());
                          Shipment shipment = Shipment(
                            senderName: _formKey.currentState?.fields['senderName']?.value,
                            senderCity: _formKey.currentState?.fields['senderCity']?.value,
                            recieverName: _formKey.currentState?.fields['recieverName']?.value,
                            recieverCity: _formKey.currentState?.fields['recieverCity']?.value,
                            shipmentType: _formKey.currentState?.fields['shipmentType']?.value,
                            packageSize: _formKey.currentState?.fields['packageSize']?.value,
                            // Add other fields as necessary
                          );
                          if (await _shipmentController.registerShipment(shipment)) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Siunta užregistruota'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainPage()),
                                      );
                                      _formKey.currentState?.reset();

                                    },
                                    child: const Text('Gerai'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text('Serverio klaida. Bandykite dar kartą.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Gerai'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                     ),
                )
              ],
            ),
          ),
        ),
        onChanged: () {},
      ),
    );
  }
}
