import '/exports/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceManager {
  static const String _deviceKey = 'deviceKey';

  static void saveDeviceKey(String deviceKey, String device_uuid) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_deviceKey, deviceKey);
    });

    Client().post(
      Uri.parse(Apis.saveDeviceId),
      body: {
        "deviceId": deviceKey,
        "league": "65590acab19d56d5417f608f",
        "device_uuid": device_uuid
      },
    ).then((value) {
      debugPrint(value.body);
    });
  }

  static Future<String?> getDeviceKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deviceKey);
  }

  static Future<void> clearDeviceKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_deviceKey);
  }

  static Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> checkDeviceId() async {
    String? deviceKey = await getDeviceKey();
    return (deviceKey == null);
  }
}
