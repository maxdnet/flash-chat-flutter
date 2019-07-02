import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/user_screen.dart';
import 'utils.dart';

void main() async {
  Widget widget = await getStartingWidget();
  runApp(FlashChat(widget));
}

class FlashChat extends StatelessWidget {
  final Widget startingWidget;
  FlashChat(this.startingWidget);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: startingWidget,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        UserScreen.id: (context) => UserScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

//Route<dynamic> _getRoute(RouteSettings settings) {
//  if (settings.name == ChatScreen.id) {
//    return _buildRoute(
//        settings,
//        ChatScreen(
//          selectedUser: settings.arguments,
//        ));
//  }
//
//  return null;
//}
//
//MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
//  return new MaterialPageRoute(
//    settings: settings,
//    builder: (ctx) => builder,
//  );
//}

Future<Widget> getStartingWidget() async {
  var user = await Utils.getRegisteredUser();
  Widget widget;
  if (user != null)
    widget = UserScreen(
      user: user,
    );
  else
    widget = WelcomeScreen();

  return widget;
}

//TODO 1 - inserire orario di invio nelle bubble chat
//TODO 2 - creare screen per utenti registrati
//TODO 3 - creare screen chat privata con utente selezionato
