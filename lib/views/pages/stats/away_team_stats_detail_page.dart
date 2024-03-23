import "/exports/exports.dart";

class HomeTeamStatsDetailPage extends StatefulWidget {
  final String homeTeam;
  final String homeTeamName;
  const HomeTeamStatsDetailPage(
      {super.key, required this.homeTeam, required this.homeTeamName});

  @override
  State<HomeTeamStatsDetailPage> createState() =>
      _HomeTeamStatsDetailPageState();
}

class _HomeTeamStatsDetailPageState extends State<HomeTeamStatsDetailPage>
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.homeTeamName),
        bottom: TabBar(
          tabs: const [
            Tab(
              text: "Top Scorers",
            ),
            Tab(
              text: "Top Artists",
            ),
            Tab(
              text: "Clean Sheets",
            ),
          ],
          controller: _topTabController,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _topTabController,
                children: [
                  TopScorers(team: widget.homeTeam),
                  TopAsists(team: widget.homeTeam),
                  CleanSheets(team: widget.homeTeam),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
