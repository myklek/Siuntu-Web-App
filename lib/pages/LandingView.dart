import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/LoginView.dart';
import 'package:siuntu_web_app/pages/RegisterView.dart';

class LandingPage extends StatelessWidget {
  void navigateToRegisterView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }
  void navigateToLoginView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savitarnos Puslapis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(250, 50), elevation: 8),
                onPressed: () {
                  navigateToLoginView(context);
                },
                child: const Text('Prisijungti'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(250, 50), elevation: 8),
                onPressed: () {
                  navigateToRegisterView(context);
                },
                child: const Text('Registruotis'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}