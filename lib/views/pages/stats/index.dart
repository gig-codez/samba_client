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
      appBar: AppBar(
        title: Text("$appTitle's Stats"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<DataController>(context, listen: false)
                  .fetchFixtures();
              Provider.of<DataController>(context, listen: false)
                  .fetchFixtureData();
              showMessage(msg: "Data refreshed");
            },
          ),
        ],
      ),
      body: const StatsPage(),
    );
  }
}
