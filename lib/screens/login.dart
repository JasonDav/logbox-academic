import 'package:flutter/material.dart';
import 'package:logbox_academic/api/security.dart';
import 'package:logbox_academic/util/validators.dart';
import 'package:provider/provider.dart';
import 'package:logbox_academic/util/extension.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle _titleStyle = TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => LoginState(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('LogBox Academic', style: _titleStyle),
              foregroundColor: const Color(0xFF3D4554),
              backgroundColor: const Color(0xFF3D4554),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => context.staticRead<LoginState>().clickSecretButton(2),
                              child: Container(
                                height: 150,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            height: 150,
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => context.staticRead<LoginState>().clickSecretButton(1),
                              child: Container(
                                height: 150,
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                    LoginForm(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text('CREATE ACCOUNT'),
                          onPressed: () => print('create account'),
                        ),
                        Container(
                          width: 20,
                        ),
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
        });
  }
}

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextStyle _hintStyle = TextStyle(color: Colors.grey);
  final TextStyle _loginStyle = TextStyle(color: Colors.white);

  final TextEditingController _usernameController = TextEditingController(text: 'paed@train.co.za');
  final TextEditingController _passwordController = TextEditingController(text: 'LogBoxMaster');

  bool _obscurePassword = true;
  bool _secretActive = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LoginState>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: Validators.username,
            decoration: InputDecoration(labelText: 'Username', labelStyle: _hintStyle),
            controller: _usernameController,
          ),
          TextFormField(
            controller: _passwordController,
            validator: Validators.password,
            decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: _hintStyle,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() {
                    _obscurePassword = !_obscurePassword;
                  }),
                )),
            obscureText: _obscurePassword,
          ),
          Container(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: state.isDevMode ? Text(
                    'DEV',
                    textAlign: TextAlign.center,
                  ) : Container(),
                  onTap: () => state.clickSecretButton(0),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF3D4554)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ))),
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      color: const Color(0xFF3D4554),
                      child: Text(
                        'SIGN IN',
                        style: _loginStyle,
                      )),
                  onPressed: () {
                    print('Signing in');
                    if (_formKey.currentState!.validate()) {
                      SecurityApi.authenticate(_usernameController.text, _passwordController.text)
                      .whenComplete(() => Navigator.of(context).pushNamed('/home'));
                    }
                  },
                ),
              ),
              Expanded(
                child: Opacity(
                  opacity: _secretActive ? 1 : 0,
                  child: GestureDetector(
                    child: Center(
                      child: Text(
                        state.isDevMode ? 'MODE' : '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () => state.clickSecretButton(3),
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

class LoginState {
  get isDevMode => lastClicked == 3;

  int lastClicked = -1;

  void clickSecretButton(int button) {
    if (button < 4 && button == lastClicked+1) {
      lastClicked++;
      print('Secret button $button clicked!');

      if (isDevMode) {
        print('Showing super secret modal!');
        lastClicked = -1;
      }
    }
  }
}
