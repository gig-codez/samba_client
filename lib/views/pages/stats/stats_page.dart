import "/exports/exports.dart";

class StatsPage extends StatefulWidget {

  const StatsPage({super.key});

  @override
  State<StatsPage> createState() =>
      _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  TabController? _topTabController;

  @override
  void initState() {
    super.initState();
    _topTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _topTabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: TabBar(
            tabs: const [
              Tab(
                text: "Top Scorers",
              ),
              Tab(
                text: "Top Assists",
              ),
              Tab(
                text: "Clean Sheets",
              ),
            ],
            controller: _topTabController,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
        Flexible(
          flex: 5,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _topTabController,
            children: [
              TopScorers(),
              TopAsists(),
              CleanSheets(),
            ],
          ),
        )
      ],
    );
  }
}
