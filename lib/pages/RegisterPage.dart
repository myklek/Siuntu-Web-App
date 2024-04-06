import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:siuntu_web_app/pages/LandingPage.dart';
import 'package:siuntu_web_app/pages/LoginPage.dart';
import 'package:siuntu_web_app/services/auth.dart' as auth;
import 'package:siuntu_web_app/pages/MainPage.dart';

final _formKey = GlobalKey<FormBuilderState>();

// Create register page with email, password and repeat password fields and register button
class RegisterPage extends StatelessWidget {
  Future<void> register() async {
    var response = await auth.register(
        _formKey.currentState!.fields['email']!.value,
        _formKey.currentState!.fields['password']!.value);
    if (response) {
      showDialog(
          context: _formKey.currentContext!,
          builder: (context) => AlertDialog(
                title: const Text('Sėkminai užregistravote'),
                content: const Text('Dabar galite prisijungti'),
                actions: [
                  TextButton(
                    onPressed: () => {Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                    )},
                    child: const Text('Gerai'),
                  ),
                ],
              ));
    } else {
      showDialog(
        context: _formKey.currentContext!,
        builder: (context) => AlertDialog(
          title: const Text('Klaida'),
          content: const Text('Nepavyko užsiregistruoti'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Gerai'),
            ),
          ],
        ),
      );
    }
  }

  final List<Widget> field = [
    FormBuilderTextField(
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
    FormBuilderTextField(
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
    FormBuilderTextField(
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registracija'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            ...field,
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.saveAndValidate()) {
                  if (_formKey.currentState!.fields['password']?.value !=
                      _formKey.currentState!.fields['repeatPassword']?.value) {
                    _formKey.currentState!.fields['repeatPassword']
                        ?.invalidate('Nesutampa slaptažodis');
                  } else {
                    print('validation success');
                    print(_formKey.currentState!.value);
                    register();
                  }
                }
              },
              child: const Text('Registruotis'),
            ),
          ],
        ),
      ),
    );
  }
}
