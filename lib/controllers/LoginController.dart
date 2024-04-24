import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/MainPage.dart';
import 'package:siuntu_web_app/services/auth.dart' as auth;
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginController {
  Future<void> login(
      BuildContext context, GlobalKey<FormBuilderState> formKey) async {
    if (formKey.currentState!.saveAndValidate()) {
      if (await auth.login(formKey.currentState!.fields['email']!.value.trim(),
          formKey.currentState!.fields['password']!.value.trim())) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      } else {
        showDialog(
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
  }
}
