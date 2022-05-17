import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  Future<void> setStringValue(String key, String value) async {
    final SharedPreferences? myPrefs = await SharedPreferences.getInstance();
    myPrefs!.setString(key, value);
  }

  Future<String?> getStringValue(String key) async {
    final SharedPreferences? myPrefs = await SharedPreferences.getInstance();
    return myPrefs!.getString(key) ?? "";
  }

  Future<bool> containsKey(String key) async {
    final SharedPreferences? myPrefs = await SharedPreferences.getInstance();
    return myPrefs!.containsKey(key);
  }

  Future<void> reload() async {
    final SharedPreferences? myPrefs = await SharedPreferences.getInstance();
    return myPrefs!.reload();
  }

  Future<bool> removeValue(String key) async {
    final SharedPreferences? myPrefs = await SharedPreferences.getInstance();
    return myPrefs!.remove(key);
  }

  Future<bool> removeAll() async {
    final SharedPreferences? myPrefs = await SharedPreferences.getInstance();
    return myPrefs!.clear();
  }
}
