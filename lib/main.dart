import 'package:flutter/material.dart';
import 'package:siuntu_web_app/pages/LandingView.dart';
import 'package:siuntu_web_app/pages/MainView.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(MyApp(
    initialRoute: token != null ? '/main' : '/land',
  ));
}
class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savitarnos Puslapis',

      darkTheme: ThemeData(
        // fontFamily: 'Roboto',
        fontFamilyFallback: ['Roboto'],
        useMaterial3: true,
        colorSchemeSeed: Color(Colors.teal.value),
      ),
      initialRoute: initialRoute,
      routes: {
        '/land': (context) => LandingPage(),
        '/main': (context) => MainPage(),
      },
    );
  }
}
