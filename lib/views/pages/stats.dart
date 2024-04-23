// import "/views/pages/stats/away_team_stats_detail_page.dart";
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
      child: HomeTeamStatsDetailPage(
        homeTeam: widget.team.league,
      ),
    );
  }
}
