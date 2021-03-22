import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextStyle _titleStyle = TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 24);
  
  List<bool> _secretButtons = List.generate(4, (_) => false);
  void _clickSecretButton(int button) {
    if (button < _secretButtons.length && button >= 0) {
      print('Secret button $button clicked!');
      _secretButtons[button] = true;

      if (!_secretButtons.any((element) => element == false)) {
        print('Showing super secret modal!');
      }
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogBox Academic',style: _titleStyle),
        foregroundColor: const Color(0xFF3D4554),
        backgroundColor: const Color(0xFF3D4554),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', height: 200,),
              LoginForm(_clickSecretButton),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text('CREATE ACCOUNT'),
                    onPressed: () => print('create account'),
                  ),
                  Container(width: 20,),
                  TextButton(
                    child: Text('FORGOT PASSWORD'),
                    onPressed: () => print('create account'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {

  /// The callback to the login screen to say that a 
  /// secret button has been clicked.
  final void Function(int) _clickSecretButtonCallback;

  LoginForm(this._clickSecretButtonCallback);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final TextStyle _hintStyle = TextStyle(color: Colors.grey);
  final TextStyle _loginStyle = TextStyle(color: Colors.white);

  bool _obscurePassword = false;
  bool _secretActive = true;


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: _hintStyle
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: _hintStyle,
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() {
                  _obscurePassword = !_obscurePassword;
                }),
              )
            ),
            obscureText: _obscurePassword,
          ),
          Container(height: 20),
          Row(
            children: [
              Expanded(
                child: Opacity(
                  opacity: _secretActive ? 1 : 0,
                  child: GestureDetector(
                    child: Text('DEV', textAlign: TextAlign.center,),
                    onTap: () => widget._clickSecretButtonCallback(0),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF3D4554)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                    )
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xFF3D4554),
                    child: Text('SIGN IN', style: _loginStyle,)
                  ),
                  onPressed: () => print('Signin'),
                ),
              ),
              Expanded(
                child: Opacity(
                  opacity: _secretActive ? 1 : 0,
                  child: GestureDetector(
                    child: Text('MODE', textAlign: TextAlign.center,),
                    onTap: () => widget._clickSecretButtonCallback(1),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}