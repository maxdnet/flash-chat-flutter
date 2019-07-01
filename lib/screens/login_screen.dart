import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/button_widget.dart';
import 'package:flash_chat/constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/user.dart';
import 'dart:io';

//final _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kInputTextDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kInputTextDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ButtonWidget(
                color: Colors.lightBlueAccent,
                textValue: 'Log In',
                onPressed: () {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    User(email: email, password: password)
                        .loginUserandNavigate(context, ChatScreen.id);
                  } catch (e) {
                    print(e);
                  } finally {
                    setState(
                      () {
                        showSpinner = false;
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
