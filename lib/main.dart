import 'package:flutter/material.dart';
import 'package:logbox_academic/screens/home.dart';
import 'package:logbox_academic/screens/login.dart';
import 'package:logbox_academic/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LogBox Academic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen()
      },
      home: SplashScreen(),
    );
  }
}