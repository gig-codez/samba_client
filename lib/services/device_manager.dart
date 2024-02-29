import '/exports/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class DeviceManager {
  static const String _deviceKey = 'deviceKey';

  static void saveDeviceKey(String deviceKey, String deviceUuid) {

    Client().post(
      Uri.parse(Apis.saveDeviceId),
      body: {
        "deviceId": deviceKey,
        "league": leagueId,
        "device_uuid": deviceUuid
      },
    ).then((value) {
      json.decode(value.body);
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
