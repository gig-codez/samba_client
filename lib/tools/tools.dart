import '../exports/exports.dart';
import '/models/fixture.dart';
import 'package:store_redirect/store_redirect.dart';

var navigatorKey = GlobalKey<NavigatorState>();
BuildContext context = navigatorKey.currentContext!;

void showMessage({String msg = "", Color? color, bool float = false}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          msg,
        ),
      ),
      behavior: float ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    ),
  );
}

// helper function
String quarterTimes(Datum data) {
  return data.quarterEnded
      ? "QT 1"
      : data.halfEnded
          ? "QT 2"
          : data.secondHalfEnded == true
              ? "QT 3"
              : data.matchEnded == true
                  ? "FT"
                  : data.kickofftime;
}

String halfTimes(Datum data) {
  return (data.halfEnded == true) && (data.matchEnded == false)
      ? "HT"
      : (data.halfEnded == true) && (data.matchEnded == true)
          ? "FT"
          : data.kickofftime;
}

String timeUpdates(Datum fixture) {
  if (fixture.isRunning == false) {
    return fixture.twohalves ? halfTimes(fixture) : quarterTimes(fixture);
  }
  return fixture.elapsedTime;
}

// showing update dialog
void showUpdateDialog({String version = '', String latestVersion = ''}) {
  BuildContext context = navigatorKey.currentContext!;
  showAdaptiveDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: Text(
          'Update Available',
          style: TextStyles(context).getBoldStyle(),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Current Version: $version",
                style: TextStyles(context).getRegularStyle(),
              ),
              Text("New Version: $latestVersion",
                  style: TextStyles(context).getRegularStyle()),
              SizedBox.square(dimension: 20),
              Text(
                  'A new version of the app is available. Please update to the latest version to continue using the app.',
                  style: TextStyles(context).getRegularStyle()),
              SizedBox.square(dimension: 20),
              CustomButton(
                text: 'Update',
                buttonColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPress: () {
                  StoreRedirect.redirect(
                    androidAppId: appBundle,
                    iOSAppId: "6451200513",
                  ).then((value) => Routes.popPage());
                  // launchPlayStore(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
