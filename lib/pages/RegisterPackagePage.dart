import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterPackagePage extends StatefulWidget {
  @override
  State<RegisterPackagePage> createState() => _RegisterPackagePageState();
}

final _formKey = GlobalKey<FormBuilderState>();
final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
List<String> packageOptions = [
  'S - iki 0.5kg 10/10/10 cm',
  'M - iki 2kg 20/20/20 cm',
  'L - iki 5kg 30/30/30 cm'];

class _RegisterPackagePageState extends State<RegisterPackagePage> {
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
              FormBuilderTextField(
                key: _emailFieldKey,
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderDropdown<String>(
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
              ),
              ElevatedButton(onPressed: () {
                // Validate and save the form values
                _formKey.currentState?.saveAndValidate();
                debugPrint(_formKey.currentState?.value.toString());

                // On another side, can access all field values without saving form with instantValues
                _formKey.currentState?.validate();
                debugPrint(_formKey.currentState?.instantValue.toString());


              },
                  child: const Text('Login'))
            ],
          ),
        ));
  }
}
