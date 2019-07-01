import 'package:shared_preferences/shared_preferences.dart';
import 'user.dart';

class Utils {
  static Future<User> getRegisteredUser() async {
    User user = null;

    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('chat_email') ?? null;
    final password = prefs.getString('chat_password') ?? null;

    if (email != null && password != null) {
      user = User(email: email, password: password);
    }

    return user;
  }

  static void saveUser(User currUser) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('chat_email', currUser.email);
    prefs.setString('chat_password', currUser.password);
  }

  static String convertDataToTime(DateTime data) {
    return '${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}';
  }
}
