import 'dart:async';
import '../controllers/data_controller.dart';
import '../services/WebSocketService.dart';
import '/exports/exports.dart';
import '/models/fixture.dart';
import '/models/league.dart';
import 'RunningTimeWidget.dart';

class LeagueWidget extends StatefulWidget {
  final Message data;
  final String matchId;
  final DataController controller;
  const LeagueWidget({
    super.key,
    required this.data,
    required this.matchId,
    required this.controller,
  });

  @override
  State<LeagueWidget> createState() => _LeagueWidgetState();
}

class _LeagueWidgetState extends State<LeagueWidget> {
  bool showHide = true;
  Timer? _timer;
  // void fetchLeagues() async {
  //   var leagues =
  //       await FixtureService.getRunningFixtures(widget.data.id, widget.matchId);
  //   _leaguesController.add(leagues);
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
  //     var leagues = await FixtureService.getRunningFixtures(
  //         widget.data.id, widget.matchId);
  //     _leaguesController.add(leagues);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) _timer = timer;
      // WebSocketService.fetchMatchTime();
      widget.controller.fetchLeagueData(
        leagueId,
      );
      widget.controller.fetchFixtureData(leagueId, widget.matchId);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

// card header
  Widget _cardHeader({String? title, String? teamLogo}) {
    BuildContext? context = navigatorKey.currentContext;
    WebSocketService.fetchMatchTime();
    WebSocketService.getServerState();
    return FittedBox(
      child: SizedBox(
        width: MediaQuery.of(context!).size.width,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: const SizedBox(),
              ),
              Text(
                title ?? "League name",
                style: Theme.of(context).textTheme.bodyLarge!.apply(
                      fontWeightDelta: 5,
                      fontSizeDelta: 3,
                    ),
              ),
              const SizedBox.square(
                dimension: 60,
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }

  // variable to hold socketData
  Map<String, dynamic> socketData = {};

  Widget cardContent({Datum? fixture, required Map<String, dynamic> socket}) {
    BuildContext? context = navigatorKey.currentContext;
    TextStyle textStyle = Theme.of(context!)
        .textTheme
        .labelLarge!
        .apply(fontWeightDelta: 5, fontSizeDelta: 3);
    return TapEffect(
      onClick: () {
        Routes.animateToPage(
          TeamsPage(
            data: fixture,
          ),
        );
      },
      child: SizedBox(
        height: 140,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RunningTimeWidget(fixture: fixture),
                Expanded(
                  flex: 4,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image(
                                  image: CachedNetworkImageProvider(fixture!.hometeam.image),
                                  width: 44,
                                  height: 44,
                                ),
                              ),
                              const SizedBox.square(
                                dimension: 14,
                              ),
                              SizedBox(
                                width: 170,
                                child: Text(
                                  fixture.hometeam.name,
                                  style: textStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox.square(
                            dimension: 10,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image(
                                    image: CachedNetworkImageProvider(fixture.awayteam.image),
                                  width: 44,
                                  height: 44,
                                ),
                              ),
                              const SizedBox.square(
                                dimension: 20,
                              ),
                              SizedBox(
                                width: 170,
                                child: Text(
                                  fixture.awayteam.name,
                                  style: textStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 20,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "${fixture.homeGoals}\n"),
                          TextSpan(text: "\n ${fixture.awayGoals}"),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }

  String msg = "";

  @override
  Widget build(BuildContext context) {
    // log(widget.matchId);
    WebSocketService.fetchMatchTime();
    WebSocketService.getServerState();
    return widget.controller.fixtureData.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/empty.svg",
                  height: 150,
                  width: 150,
                ),
                const Text("No fixture yet set for today!"),
                // OutlinedButton.icon(onPressed: (){}, icon: icon, label: Text("Add "))
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            margin: const EdgeInsets.fromLTRB(10, 11, 10, 11),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child:
                Consumer<DataController>(builder: (context, controller, child) {
              return Column(
                children: [
                  _cardHeader(
                    title: widget.data.name,
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  ...List.generate(
                    controller.fixtureData.length,
                    (i) => cardContent(
                      fixture: controller.fixtureData[i],
                      socket: socketData,
                    ),
                  ),
                ],
              );
            }),
          );
  }
}
