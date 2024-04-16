import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:siuntu_web_app/models/Package.dart';


class ShipmentSizeDropdown extends StatelessWidget {
  final List<Package> packageOptions;
  const ShipmentSizeDropdown({super.key, required this.packageOptions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderDropdown<String>(
        name: 'package',
        decoration: InputDecoration(
          labelText: 'Siuntos Dydis',
          hintText: 'Pasirinkite siuntos dydį',
          border: OutlineInputBorder(),
        ),
        items: packageOptions
            .map((package) => DropdownMenuItem(
                  value: package.id.toString(),
                  child: Text('${package.name} - ${package.width}cm x ${package.height}cm x ${package.length}cm'),
                ))
            .toList(),
      ),
    );
  }
}
