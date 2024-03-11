import '../exports/exports.dart';
import '/models/fixture.dart';

var navigatorKey = GlobalKey<NavigatorState>();

void showMessage({String msg = "", Color? color}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        msg,
      ),
    ),
  );
}

String timeUpdates(Datum fixture) {
  if (fixture.isRunning == false) {
    if (fixture.matchEnded) {
      return "FT";
    } else if (fixture.halfEnded && fixture.firstHalfEnded) {
      return "HT";
    }
    return fixture.kickofftime;
  }
  return fixture.elapsedTime;
}
