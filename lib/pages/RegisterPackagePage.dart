import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:siuntu_web_app/widgets/ShipmentSizeDropdown.dart';
import 'package:siuntu_web_app/widgets/ShipmentTypeRadioGroup.dart';
import 'package:siuntu_web_app/pages/MainPage.dart'; // Import MainPage
import 'package:siuntu_web_app/services/shipments.dart';



import 'MainPage.dart';

class RegisterPackagePage extends StatefulWidget {
  @override
  State<RegisterPackagePage> createState() => _RegisterPackagePageState();
}

final _formKey = GlobalKey<FormBuilderState>();
List<String> packageOptions = [
  'S - iki 0.5kg 10/10/10 cm',
  'M - iki 2kg 20/20/20 cm',
  'L - iki 5kg 30/30/30 cm'
];

class _RegisterPackagePageState extends State<RegisterPackagePage> {
  bool isSelfPack = false;

  List<Widget> forms = [
    FormBuilderTextField(
      name: 'senderName',
      decoration: const InputDecoration(labelText: 'Siuntėjo vardas'),
      validator:
          FormBuilderValidators.compose([FormBuilderValidators.required()]),
    ),
    FormBuilderTextField(
      name: 'senderCity',
      decoration: const InputDecoration(labelText: 'Siuntėjo miestas'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    ),
    Divider(color: Colors.white, height: 20),
    FormBuilderTextField(
      name: 'recieverName',
      decoration: const InputDecoration(labelText: 'Gavėjo Vardas'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    ),
    FormBuilderTextField(
      name: 'recieverCity',
      decoration: const InputDecoration(labelText: 'Gavėjo miestas'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    ),
    Divider(color: Colors.white, height: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Užregistruoti siuntą'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            ...forms,
            ShipmentTypeRadioGroup(
                callback: (value) => setState(() => isSelfPack = value)),
            if (isSelfPack) ShipmentSizeDropdown(),
            ElevatedButton(
                onPressed: () async {

                  _formKey.currentState?.saveAndValidate();
                  debugPrint(_formKey.currentState?.value.toString());
                  debugPrint(json.encode(_formKey.currentState?.value));

                  if (_formKey.currentState?.saveAndValidate() == true) {
                    if (await registerShipment(
                        json.encode(_formKey.currentState?.value))) {
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

                  // debugPrint(_formKey.currentState?.instantValue.jsify().toString());
                  // print(_formKey.currentState?.instantValue.jsify().toString());
                  // print(_formKey.currentState?.instantValue.toJSBox.toString());
                },
                child: const Text('Sukurti naują siuntą'))
          ],
        ),
        onChanged: () {},
      ),
    );
  }
}

