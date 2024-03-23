import "/exports/exports.dart";

class CleanSheets extends StatefulWidget {
  final String team;
  const CleanSheets({super.key,required this.team});

  @override
  State<CleanSheets> createState() => _CleanSheetsState();
}

class _CleanSheetsState extends State<CleanSheets> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Clean Sheets Yet."),
    );
  }
}
