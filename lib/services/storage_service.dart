import "/exports/exports.dart";
class StorageSerivce {
  // inititalise shareprefs
  static Future<SharedPreferences> _init() async {
    return await SharedPreferences.getInstance();
  }
  // function to store data
  static Future<void> storeData(String key, dynamic value) async {
    SharedPreferences _prefs = await _init();
    if (value is String) {
      _prefs.setString(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      _prefs.setStringList(key, value);
    }
  }

  // function to retrive data
  static Future<dynamic> retriveData(String key) async {
    SharedPreferences _prefs = await _init();
    return _prefs.get(key);
  }
}