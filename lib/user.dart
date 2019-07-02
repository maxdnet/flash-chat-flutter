import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils.dart';

final _auth = FirebaseAuth.instance;

class User {
  final String email;
  final String password;
  final String uidSelected;
  final String uidCurrent;
  final String username;
  final int idSelected;
  int idCurrent;

  User(
      {this.email,
      this.password,
      this.uidSelected,
      this.username,
      this.uidCurrent,
      this.idCurrent,
      this.idSelected});

  void loginUserandNavigate(BuildContext context, String navigateTo) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        //Salvo utente nelle sharedPrefs
        Utils.saveUser(User(email: email, password: password));
        Navigator.pushNamed(context, navigateTo);
      }
    } catch (e) {
      print(e);
    }
  }

  void loginUser(BuildContext context) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        //Salvo utente nelle sharedPrefs
        Utils.saveUser(User(email: email, password: password));
      }
    } catch (e) {
      print(e);
    }
  }
}
