import '../exports/exports.dart';

class PlayingTeams extends StatelessWidget {
  final int? data;
  final String matchId;
  const PlayingTeams({super.key, required this.matchId, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataController>(builder: (context, controller, c) {
      controller.fetchLeagueData();
      controller.fetchFixtureData(matchId);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 100,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    controller.fixtureData[data!].hometeam.image,
                    width: 55,
                    height: 55,
                  ),
                ),
                Text(controller.fixtureData[data!].hometeam.name,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: controller.fixtureData[data!].isLive
                          ? "${controller.fixtureData[data!].homeGoals} - ${controller.fixtureData[data!].awayGoals}"
                          : timeUpdates(controller.fixtureData[data!]),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    // TextSpan(
                    //   text: "Full-Time",
                    //   style: Theme.of(context).textTheme.titleMedium,
                    // ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    controller.fixtureData[data!].awayteam.image,
                    width: 55,
                    height: 55,
                  ),
                ),
                Text(controller.fixtureData[data!].awayteam.name,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      );
    });
  }
}
