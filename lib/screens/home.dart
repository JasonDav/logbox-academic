import 'package:flutter/material.dart';
import 'package:logbox_academic/model/state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstname = RootState().user.name;
    var lastname = RootState().user.surname;
    return Scaffold(
      body: Container(
        child: Center(child: Text("$firstname $lastname")),
      ),
    );
  }
}
