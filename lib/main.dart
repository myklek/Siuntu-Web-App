
import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/LandingPage.dart';
import 'package:siuntu_web_app/pages/LoginPage.dart';
import 'package:siuntu_web_app/pages/MainPage.dart'; // Import MainPage
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(MyApp(
    initialRoute: token != null ? '/main' : '/login',
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savitarnos Puslapis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/main': (context) => MainPage(), // Add MainPage to routes
      },
    );
  }
}

// Create landing page with login and register buttons with router to navigate to login and register pages
