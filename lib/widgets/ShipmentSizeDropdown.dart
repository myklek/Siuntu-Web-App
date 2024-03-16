import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

List<String> packageOptions = [
  'S - iki 0.5kg 10/10/10 cm',
  'M - iki 2kg 20/20/20 cm',
  'L - iki 5kg 30/30/30 cm'
];

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
