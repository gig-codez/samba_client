import "/exports/exports.dart";
import "dart:convert";

class UpdateService {
  static Future<String> getVersion() async {
    Response response = await Client().get(Uri.parse(Apis.update));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['version'];
      return data;
    }
    return "";
  }
}
