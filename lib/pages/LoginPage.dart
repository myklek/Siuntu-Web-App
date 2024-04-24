import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:siuntu_web_app/controllers/LoginController.dart';

final _formKey = GlobalKey<FormBuilderState>();

class LoginPage extends StatelessWidget {
  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prisijungimas')),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: 'email',
                    initialValue: 'mykolas@email.com',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'El. paštas',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Laukas privalomas'),
                      FormBuilderValidators.email(errorText: 'Neteisingas el. pašto formatas'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    name: 'password',
                    initialValue: '12345678',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Slaptažodis',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Laukas privalomas'),
                      FormBuilderValidators.minLength(8, errorText: 'Slaptažodis turi būti bent 8 simbolių'),
                    ]),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _loginController.login(context, _formKey),
                  child: const Text('Prisijungti'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}