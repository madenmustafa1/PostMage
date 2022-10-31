// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferences? prefs;

  //Init prefs
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  //Set prefs
  void setInt(String key, int value) async {
    if (prefs == null) await initPrefs();
    await prefs!.setInt(key, value);
  }

  void setBool(String key, bool value) async {
    if (prefs == null) await initPrefs();
    await prefs!.setBool(key, value);
  }

  void setString(String key, String value) async {
    if (prefs == null) await initPrefs();
    await prefs!.setString(key, value);
  }

  //Get prefs
  String? getString(String key) => prefs!.getString(key);
  int? getInt(String key) => prefs!.getInt(key);
  bool? getBool(String key) => prefs!.getBool(key);

  //Key
  final String TOKEN = "TOKEN";
  final String USER_ID = "USER_ID";
}
