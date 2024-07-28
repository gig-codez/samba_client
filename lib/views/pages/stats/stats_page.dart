import "package:fau/views/pages/stats/ast_page.dart";
import "package:fau/views/pages/stats/blk_page.dart";
import "package:fau/views/pages/stats/gsl_page.dart";
import "package:fau/views/pages/stats/ks_page.dart";
import "package:fau/views/pages/stats/mx_page.dart";
import "package:fau/views/pages/stats/rc_page.dart";
import "package:fau/views/pages/stats/ste_page.dart";
import "package:fau/views/pages/stats/two_min_page.dart";

import "../../../controllers/league_controller.dart";
import "/exports/exports.dart";

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  TabController? _topTabController;

  @override
  void initState() {
    super.initState();
    _topTabController = TabController(length: 9, vsync: this);
  }

  @override
  void dispose() {
    _topTabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataController>(builder: (context, controller, x) {
      if (mounted) {
        controller.fetchMatchDates();
        controller.fetchFixtures();
        controller.fetchFixtureData();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(3),
                children:
                    context.read<LeagueController>().leagues.map((league) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TapEffect(
                      onClick: () {
                        context.read<LeagueController>().switchLeague(league);
                      },
                      child: Chip(
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        backgroundColor: leagueId == league.leagueId
                            ? Theme.of(context).primaryColor
                            : null,
                        avatar: Icon(
                          leagueId == league.leagueId
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color:
                              leagueId == league.leagueId ? Colors.white : null,
                        ),
                        label: AutoSizeText(
                          league.appTitle,
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                                color: leagueId == league.leagueId
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                                fontWeightDelta: 4,
                              ),
                          maxFontSize: 18,
                          minFontSize: 10,
                          group: AutoSizeGroup(),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          /**  "TO": 0,
          "GLS": 0,
          "AST": 0,
          "MX": 0,
          "BLK": 0,
          "STE": 0,
          "KS": 0,
          "TWO_MIN": 0,
          "RC": 0,
           */
          Flexible(
            flex: 5,
            child: TabBar(
              isScrollable: true,
              tabs: const [
                // cater for handball stats
                Tab(
                  text: "TO",
                ),
                Tab(
                  text: "GLS",
                ),
                Tab(
                  text: "AST",
                ),
                Tab(
                  text: "MX",
                ),
                Tab(
                  text: "BLK",
                ),
                Tab(
                  text: "STE",
                ),
                Tab(
                  text: "KS",
                ),
                Tab(
                  text: "TWO_MIN",
                ),
                Tab(
                  text: "RC",
                ),
              ],
              controller: _topTabController,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          Flexible(
            flex: 5,
            child: TabBarView(
              // physics: const NeverScrollableScrollPhysics(),
              controller: _topTabController,
              children: const [
                // display handball stats
                TOPage(),
                GslPage(),
                MxPage(),
                AstPage(),
                BlkPage(),
                StePage(),
                KsPage(),
                TwoMinPage(),
                RcPage(),
              ],
            ),
          )
        ],
      );
    });
  }
}
