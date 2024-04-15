import 'package:flutter/material.dart';
import 'package:siuntu_web_app/controllers/LandingController.dart';
class LandingPage extends StatelessWidget {
  final LandingController _landingController = LandingController();

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
                onPressed: () {
                  _landingController.navigateToLogin(context);
                },
                child: const Text('Prisijungti'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _landingController.navigateToRegister(context);
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