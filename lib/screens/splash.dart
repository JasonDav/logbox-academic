import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      // todo load local cache 
      // todo determine network connectivity
    ]).whenComplete(() => Navigator.of(context).pushReplacementNamed('/login'));


    return Container(
      child: Scaffold(
        body: Center(
          child: Container(
            width: 200,
            child: RiveAnimation.asset('assets/animations/heart_rate_loader.riv', fit: BoxFit.fitWidth,)
          )
        ),
      ),
    );
  }
}