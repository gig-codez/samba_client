import "/exports/exports.dart";
// import "dart:convert";

class BlogService {
  // function to fetch blogs
  static Future<List<BlogsModel>> getBlogs(String league) async {
    try {
      var response = await Client().get(Uri.parse("${Apis.blogs}/$league"));
      if (response.statusCode == 200) {
        return blogsModelFromJson(response.body);
      } else {
        showMessage(msg: response.reasonPhrase ?? "Error fetching blogs");
        return [];
      }
    } on Exception catch (e, _) {
      debugPrint("Error $_");
      return [];
    }
  }
}
