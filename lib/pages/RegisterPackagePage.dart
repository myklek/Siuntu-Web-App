import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:siuntu_web_app/widgets/ShipmentSizeDropdown.dart';
import 'package:siuntu_web_app/widgets/ShipmentTypeRadioGroup.dart';

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
                onPressed: () {
                  // Validate and save the form values
                  // _formKey.currentState?.saveAndValidate();
                  // debugPrint(_formKey.currentState?.value.toString());

                  // On another side, can access all field values without saving form with instantValues
                  _formKey.currentState?.validate();
                  debugPrint(_formKey.currentState?.instantValue.toString());
                },
                child: const Text('Sukurti naują siuntą'))
          ],
        ),
        onChanged: () {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            forms.add(Text('test'));
          });
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}

class ShipmentSizeDropdown extends StatelessWidget {
  const ShipmentSizeDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: 'packageSize',
      decoration: InputDecoration(
        labelText: 'Siuntos Dydis',
        hintText: 'Pasirinkite siuntos dydį',
      ),
      items: packageOptions
          .map((size) => DropdownMenuItem(
                value: size[0],
                child: Text(size),
              ))
          .toList(),
    );
  }
}

class ShipmentTypeRadioGroup extends StatelessWidget {
  final callback;

  ShipmentTypeRadioGroup({required this.callback});

  @override
  Widget build(BuildContext context) {
    return FormBuilderRadioGroup(
        name: 'shipmentType',
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        options: [
          FormBuilderFieldOption(
              value: 'self-pack', child: const Text('Supakuosiu pats')),
          FormBuilderFieldOption(
              value: 'self-service',
              child: const Text('Supakuosiu savitarnoje')),
        ],
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
        onChanged: (value) {
          if (value == 'self-pack')
            callback(true);
          else
            callback(false);
        });
  }
}
