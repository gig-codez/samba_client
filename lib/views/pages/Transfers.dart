// import '/services/player_service.dart';
import '../../controllers/league_controller.dart';
import '../../exports/exports.dart';
import '../../widgets/TransferWidget.dart';

class TransfersPage extends StatefulWidget {
  const TransfersPage({super.key});

  @override
  State<TransfersPage> createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfers"),
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
      body: SafeArea(
        child: Consumer<DataController>(builder: (context, controller, x) {
          if (mounted) {
            controller.fetchMatchDates();
            controller.fetchFixtures();
            controller.fetchFixtureData();
          }
          return Column(
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
                            context
                                .read<LeagueController>()
                                .switchLeague(league);
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
                              color: leagueId == league.leagueId
                                  ? Colors.white
                                  : null,
                            ),
                            label: AutoSizeText(
                              league.appTitle,
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.apply(
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
              Consumer<PlayerController>(builder: (context, controller, st) {
                return controller.transfers.isEmpty
                    ? const Center(
                        child: Text("No transferred player yet."),
                      )
                    : Flexible(
                        flex: 5,
                        child: ListView.builder(
                          itemCount: controller.transfers.length,
                          itemBuilder: (context, index) {
                            return TransferWidget(
                              player: controller.transfers[index],
                            );
                          },
                        ),
                      );
              }),
            ],
          );
        }),
      ),
    );
  }
}
