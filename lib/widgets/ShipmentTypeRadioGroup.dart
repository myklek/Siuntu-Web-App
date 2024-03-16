import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
              value: 'SELF_PACK', child: const Text('Supakuosiu pats')),
          FormBuilderFieldOption(
              value: 'SELF_SERVICE',
              child: const Text('Supakuosiu savitarnoje')),
        ],
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
        onChanged: (value) {
          if (value == 'SELF_PACK')
            callback(true);
          else
            callback(false);
        });
  }
}
