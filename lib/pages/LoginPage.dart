import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/MainPage.dart';
import 'package:siuntu_web_app/services/auth.dart' as auth;

// Create login page with email and password fields and login button
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //get text from email and password fields
  final TextEditingController _emailController = TextEditingController(text: 'test@email.com');
  final TextEditingController _passwordController = TextEditingController(text: 'password');

  //create login function on login press
  Future<void> login() async {
    if (await auth.login(
        _emailController.text.trim(), _passwordController.text.trim())) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid email or password'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prisijungimas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'El. paštas',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Slaptažodis',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: const Text('Prisijungti'),
            ),
          ],
        ),
      ),
    );
  }
}
