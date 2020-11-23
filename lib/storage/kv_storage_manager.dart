
import 'package:shared_preferences/shared_preferences.dart';

class KVStorageManager {
  
  static Future<SharedPreferences> _getSP() async {
    return await SharedPreferences.getInstance(); 
  }
  
  static void setString(String key, String value) async {
    try {
      SharedPreferences sharedPreferences = await _getSP();
      sharedPreferences.setString(key, value);
    } catch (e) {
      print(e);
    }
  }

  static Future<String> getString(String key, { String defaultValue = '' }) async {
    return (await _getSP()).getString(key) ?? defaultValue;
  }

  static void setInt(String key, int value) async {
    try {
      SharedPreferences sharedPreferences = await _getSP();
      sharedPreferences.setInt(key, value);
    } catch (e) {
      print(e);
    }
  }

  static Future<int> getInt(String key, { int defaultValue = 0 }) async {
    return (await _getSP()).getInt(key) ?? defaultValue;
  }
  
}
