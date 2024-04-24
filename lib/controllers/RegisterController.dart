import 'package:flutter/material.dart';
import 'package:siuntu_web_app/models/User.dart';
import 'package:siuntu_web_app/pages/LandingPage.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:siuntu_web_app/services/auth.dart' as auth;

class RegisterController {
  Future<void> register(BuildContext context, GlobalKey<FormBuilderState> formKey) async {
    if (formKey.currentState!.saveAndValidate()) {
      if (formKey.currentState!.fields['password']?.value !=
          formKey.currentState!.fields['repeatPassword']?.value) {
        formKey.currentState!.fields['repeatPassword']
            ?.invalidate('Nesutampa slaptažodis');
      } else {

        User user = User(
          email: formKey.currentState!.fields['email']!.value.trim(),
          password: formKey.currentState!.fields['password']!.value.trim(),
        );
        if (await auth.register(user.email, user.password)) {
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
  }
}