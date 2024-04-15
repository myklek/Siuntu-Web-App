import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:siuntu_web_app/controllers/AuthController.dart';
import 'package:siuntu_web_app/models/User.dart';
import 'package:siuntu_web_app/pages/LandingPage.dart';

final _formKey = GlobalKey<FormBuilderState>();

// Create register page with email, password and repeat password fields and register button
class RegisterPage extends StatelessWidget {
  final AuthController _authController = AuthController();

  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState!.saveAndValidate()) {
      User user = User(
        email: _formKey.currentState!.fields['email']!.value.trim(),
        password: _formKey.currentState!.fields['password']!.value.trim(),
      );
      if (await _authController.register(user)) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Registracija'),
                  content: const Text('Registracija sėkminga'),
                  actions: [
                    TextButton(
                        onPressed: () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LandingPage()),
                              )
                            },
                        child: const Text('Gerai'))
                  ],
                ));
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Klaida'),
            content: const Text('Nepavyko užsiregistruoti'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Gerai'))
            ],
          ),
        );
      }
    }
  }

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
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        if (_formKey.currentState!.fields['password']?.value !=
                            _formKey.currentState!.fields['repeatPassword']?.value) {
                          _formKey.currentState!.fields['repeatPassword']
                              ?.invalidate('Nesutampa slaptažodis');
                        } else {
                          _register(context);
                        }
                      }
                    },
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
