import '/exports/exports.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  // SharedPreferences _prefs =  await SharedPreferences.getInstance();
  int isLight = 1;
  int isDark = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(builder: (context, controller, child) {
      return SizedBox(
        height: 200,
        child: Column(
          children: [
            RadioListTile(
              title: const Text("Light Theme"),
              value: controller.appTheme == 1 ? 1 : -1,
              groupValue: 1,
              onChanged: (x) {
                  StorageSerivce.storeData("theme",1);
                Routes.popPage();
              },
            ),
            RadioListTile(
              title: const Text("Dark Theme"),
              value: controller.appTheme == 2 ? 1 : -1,
              groupValue: 1,
              onChanged: (x) {
                StorageSerivce.storeData("theme",2);
                Routes.popPage();
              },
            ),
            RadioListTile(
              title: const Text("Follow System"),
              value: controller.appTheme == 3 ? 1 : -1,
              groupValue: 1,
              onChanged: (x) {
                
                StorageSerivce.storeData("theme", 3);
                Routes.popPage();
              },
            ),
          ],
        ),
      );
    });
  }
}
