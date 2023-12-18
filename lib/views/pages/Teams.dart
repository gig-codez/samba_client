import '/models/fixture.dart';
import '/views/pages/teamPages/LineUp.dart';

import '../../widgets/PlayingTeams.dart';
import '/exports/exports.dart';
import 'teamPages/stats_page.dart';
import 'teamPages/table_page.dart';

class TeamsPage extends StatefulWidget {
  final Datum data;
  const TeamsPage({super.key, required this.data});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> with TickerProviderStateMixin {
  TabController? _topTabController;

  @override
  void initState() {
    super.initState();
    _topTabController = TabController(length: 2, vsync: this);
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
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PlayingTeams(data: widget.data),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        tabs: const [
                          Tab(
                            text: "Line Up",
                          ),
                          Tab(
                            text: "Table",
                          ),
                        ],
                        controller: _topTabController,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _topTabController,
                          children: [
                            LineUpPage(
                              homeTeamId: widget.data.hometeam.id,
                              awayTeamId: widget.data.awayteam.id,
                            ),
                            TablePage(
                              leagueId: widget.data.league,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Routes.popPage(),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
