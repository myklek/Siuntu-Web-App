import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:siuntu_web_app/models/Package.dart';

import 'package:siuntu_web_app/widgets/ShipmentSizeDropdown.dart';
import 'package:siuntu_web_app/widgets/ShipmentTypeRadioGroup.dart';
import 'package:siuntu_web_app/pages/MainView.dart'; // Import MainPage
import 'package:siuntu_web_app/controllers/ShipmentController.dart';
import 'package:siuntu_web_app/models/Shipment.dart';


final _formKey = GlobalKey<FormBuilderState>();


class CreateShipmentView extends StatefulWidget {
  @override
  State<CreateShipmentView> createState() => _CreateShipmentViewState();
}

class _CreateShipmentViewState extends State<CreateShipmentView> {
  bool isSelfPack = false;
  final ShipmentController _shipmentController = ShipmentController();
  List<Package> packages = [];

  @override
  void initState() {
    super.initState();
    fetchPackages();
  }

  Future<void> fetchPackages() async {
    print('call fetch');
    packages = await _shipmentController.getPackages();
  }

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
        name: 'senderAddress',
        decoration: const InputDecoration(labelText: 'Siuntėjo adresas',border: OutlineInputBorder(),),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'senderPhoneNumber',
        decoration: const InputDecoration(labelText: 'Siuntėjo telefono numeris',border: OutlineInputBorder(),),
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
        name: 'recieverAddress',
        decoration: const InputDecoration(labelText: 'Gavėjo adresas',border: OutlineInputBorder()),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'recieverPhoneNumber',
        decoration: const InputDecoration(labelText: 'Gavėjo telefono numeris',border: OutlineInputBorder()),
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
                if (isSelfPack) ShipmentSizeDropdown(packageOptions: packages),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      child: const Text('Sukurti naują siuntą'),
                      onPressed: () async {
                        if (_formKey.currentState?.saveAndValidate() == true) {
                          print(_formKey.currentState?.value.toString());
                          Shipment shipment = Shipment(
                            senderName: _formKey.currentState?.fields['senderName']?.value,
                            senderAddress: _formKey.currentState?.fields['senderAddress']?.value,
                            senderPhoneNumber: _formKey.currentState?.fields['senderPhoneNumber']?.value,
                            recieverName: _formKey.currentState?.fields['recieverName']?.value,
                            recieverAddress: _formKey.currentState?.fields['recieverAddress']?.value,
                            recieverPhoneNumber: _formKey.currentState?.fields['recieverPhoneNumber']?.value,
                            shipmentType: _formKey.currentState?.fields['shipmentType']?.value,
                            package: _formKey.currentState?.fields['package']?.value != null ? Package(id: int.parse( _formKey.currentState?.fields['package']?.value)) : null,
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
                                      navigateToMainPage(context);
                                    },
                                    child: const Text('Gerai'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            showError(context);
                          }
                        }
                      },
                     ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showError(BuildContext context) {
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

  void navigateToMainPage(BuildContext context) {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MainPage()),
    );
    _formKey.currentState?.reset();
  }
}
