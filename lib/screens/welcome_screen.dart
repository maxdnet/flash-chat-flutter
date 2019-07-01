import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/widgets/button_widget.dart';
import 'package:flash_chat/utils.dart';
import 'package:flash_chat/user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'user_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool showSpinner = false;
  //AnimationController controller;
  //Animation animation;

  @override
  void initState() {
    super.initState();
//    controller = AnimationController(
//      vsync: this,
//      duration: Duration(seconds: 1),
//    );
//
//    animation = ColorTween(begin: Colors.blueGrey, end: Colors.grey[900])
//        .animate(controller);
//    controller.forward();
//    controller.addListener(() {
//      setState(() {
//        //print(controller.value);
//      });
//    });
  }

  void getUser() async {
    var user = await Utils.getRegisteredUser();
    if (user != null) {
      User(email: user.email, password: user.password)
          .loginUserandNavigate(context, UserScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: animation.value,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                  TyperAnimatedTextKit(
                      duration: Duration(seconds: 1),
                      isRepeatingAnimation: false,
                      text: ['Elite chat'],
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.start,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              ButtonWidget(
                color: Colors.lightBlueAccent,
                textValue: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              ButtonWidget(
                color: Colors.blueAccent,
                textValue: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
