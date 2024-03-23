import "/views/pages/stats/away_team_stats_detail_page.dart";
import '/models/fixture.dart';
import "/exports/exports.dart";

class StatsPage extends StatefulWidget {
  final Datum team;
  const StatsPage({super.key, required this.team});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileWidget(
              titleText: widget.team.hometeam.name,
              img: widget.team.hometeam.image,
              onPress: () => Routes.animateToPage(
                HomeTeamStatsDetailPage(
                  homeTeam: widget.team.hometeam.id,
                  homeTeamName: widget.team.hometeam.name,
                ),
              ),
              // cotetech256
            ),
            const SizedBox.square(dimension: 20),
            ProfileWidget(
              img: widget.team.awayteam.image,
              titleText: widget.team.awayteam.name,
              onPress: () => Routes.animateToPage(
               AwayTeamStatsDetailPage(
                  awayTeam: widget.team.awayteam.id,
                  awayTeamName: widget.team.awayteam.name,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
