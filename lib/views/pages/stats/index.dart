import "/exports/exports.dart";

class IndexStats extends StatefulWidget {
  const IndexStats({super.key});

  @override
  State<IndexStats> createState() => _IndexStatsState();
}

class _IndexStatsState extends State<IndexStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("$appTitle's Stats"),
      ),
      body:const StatsPage(),
    );
  }
}