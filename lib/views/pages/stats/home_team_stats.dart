import "/exports/exports.dart";

class AwayTeamStatsDetailPage extends StatefulWidget {
  final String awayTeam;
  final String awayTeamName;
  const AwayTeamStatsDetailPage(
      {super.key, required this.awayTeam, required this.awayTeamName});

  @override
  State<AwayTeamStatsDetailPage> createState() =>
      _AwayTeamStatsDetailPageState();
}

class _AwayTeamStatsDetailPageState extends State<AwayTeamStatsDetailPage>
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
        title: Text(widget.awayTeamName),
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
                  TopScorers(team: widget.awayTeam),
                  TopAsists(team: widget.awayTeam),
                  CleanSheets(team: widget.awayTeam),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
