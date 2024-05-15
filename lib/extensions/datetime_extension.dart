import 'package:intl/intl.dart';

// import '../exports/exports.dart';

extension DateTimeUtil on DateTime {
  String formated() {
    String stringDate = DateFormat('EEE d MMM').format(this);
    String currentDate = DateFormat('EEE d MMM').format(DateTime.now());
    // Customize the logic to determine the label based on the relation to the current date
    if (stringDate.split(" ").first == currentDate.split(" ").first &&
        stringDate.split(" ")[1] == currentDate.split(" ")[1] &&
        (stringDate.split(" ").last == currentDate.split(" ").last)) {
      return 'Today';
    } else if (int.parse(stringDate.split(" ")[1]) ==
            (int.parse(currentDate.split(" ")[1]) - 1) &&
        (stringDate.split(" ").last == currentDate.split(" ").last)) {
      return 'Yesterday';
    } else if (int.parse(stringDate.split(" ")[1]) ==
            (int.parse(currentDate.split(" ")[1]) + 1) &&
        (stringDate.split(" ").last == currentDate.split(" ").last)) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEE d MMM').format(this);
    }
  }

  String get timeAgo {
    // final locale = Localizations.localeOf(context);
    // print(toUtc().toString());
    DateTime now = DateTime.now().toUtc();
    final difference = now.difference(toUtc());
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('dd MMM yyyy').format(toUtc());
    }
  }
}
