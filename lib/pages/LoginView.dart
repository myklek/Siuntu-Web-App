import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:siuntu_web_app/controllers/AuthenticationController.dart';
import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/MainView.dart';
import 'package:siuntu_web_app/services/AuthService.dart' as auth;
import 'package:flutter_form_builder/flutter_form_builder.dart';

final _formKey = GlobalKey<FormBuilderState>();

class LoginPage extends StatelessWidget {
  final AuthenticationController _authenticationController =
      AuthenticationController();

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
                      FormBuilderValidators.required(
                          errorText: 'Laukas privalomas'),
                      FormBuilderValidators.email(
                          errorText: 'Neteisingas el. pašto formatas'),
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
                      FormBuilderValidators.required(
                          errorText: 'Laukas privalomas'),
                      FormBuilderValidators.minLength(8,
                          errorText: 'Slaptažodis turi būti bent 8 simbolių'),
                    ]),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(250, 50), elevation: 8),
                  onPressed: () async => {
                    if (_formKey.currentState!.saveAndValidate())
                      {
                        if (await login())
                          {navigateToMainPage(context)}
                        else
                          {showError(context)}
                      }
                  },
                  child: const Text('Prisijungti'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> login() async {
    return await _authenticationController.login(
        _formKey.currentState!.fields['email']!.value.trim(),
        _formKey.currentState!.fields['password']!.value.trim());
  }

  Future<dynamic> navigateToMainPage(BuildContext context) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  Future<dynamic> showError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Klaida'),
        content: Text('Nepavyko prisijungti'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Gerai'))
        ],
      ),
    );
  }
}
