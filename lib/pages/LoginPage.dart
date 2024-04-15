import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:siuntu_web_app/pages/MainPage.dart';
import 'package:siuntu_web_app/controllers/AuthController.dart';
import 'package:siuntu_web_app/models/User.dart';

final _formKey = GlobalKey<FormBuilderState>();

class LoginPage extends StatelessWidget {
  final AuthController _authController = AuthController();

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.saveAndValidate()) {
      User user = User(
        email: _formKey.currentState!.fields['email']!.value.trim(),
        password: _formKey.currentState!.fields['password']!.value.trim(),
      );
      if (await _authController.login(user)) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Klaida'),
            content: Text('Nepavyko prisijungti'),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Gerai'))],
          ),
        );
      }
    }
  }

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
                  onPressed: () => _login(context),
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