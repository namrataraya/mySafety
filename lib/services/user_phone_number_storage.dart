import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  static String phoneKey = 'PhoneKey';

  static Future<bool> savePhoneNumber(String userPhoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(phoneKey, userPhoneNumber);
  }

  static Future<String?> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    return await prefs.getString(phoneKey);
  }
}
