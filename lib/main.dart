import 'package:flutter/material.dart';
import 'package:logbox_academic/model/state.dart';
import 'package:logbox_academic/screens/home.dart';
import 'package:logbox_academic/screens/login.dart';
import 'package:logbox_academic/screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [Provider(create: (_) => RootState())],
        child: MaterialApp(
          title: 'LogBox Academic',
          navigatorKey: navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/login': (context) => LoginScreen(),
            '/home': (context) => HomeScreen()
          },
          home: SplashScreen(),
        ));
  }
}
