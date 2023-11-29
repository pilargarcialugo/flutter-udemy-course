import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  
  static bool _isDarkModeEnabled = false;
  static int _gender = 1;
  static String _name = '';
  
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkModeenabled {
    return _prefs.getBool('isDarkModeEnabled') ?? _isDarkModeEnabled;
  }

  static set isDarkModeEnabled (bool isDarkModeEnabled) {
    _isDarkModeEnabled = isDarkModeEnabled;
    _prefs.setBool('isDarkModeEnables', isDarkModeEnabled);
  }

  static int get gender {
    return _prefs.getInt('gender') ?? _gender;
  }

  static set gender (int gender) {
    _gender = gender;
    _prefs.setInt('gender', gender);
  }

  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name (String name) {
    _name = name;
    _prefs.setString('name', name);
  }
}
