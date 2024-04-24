import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:siuntu_web_app/controllers/RegisterController.dart';

final _formKey = GlobalKey<FormBuilderState>();

class RegisterPage extends StatelessWidget {
  final RegisterController _registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registracija'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: 'email',
                    enableSuggestions: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'El. paštas',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Laukas privalomas'),
                      FormBuilderValidators.email(
                          errorText: 'Neteisingas el. pašto formatas'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Slaptažodis',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Laukas privalomas'),
                      FormBuilderValidators.minLength(8,
                          errorText: 'Slaptažodis turi būti bent 8 simbolių'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: 'repeatPassword',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pakartokite slaptažodį',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Laukas privalomas'),
                      FormBuilderValidators.minLength(8,
                          errorText: 'Slaptažodis turi būti bent 8 simbolių'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _registerController.register(context, _formKey),
                    child: const Text('Registruotis'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}