import 'dart:async';
import '../controllers/data_controller.dart';
import '/exports/exports.dart';
import '/models/fixture.dart';
import '/models/league.dart';

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
      setState(() {
        _timer = timer;
      });
      widget.controller.fetchLeagueData(
        "65590acab19d56d5417f608f",
      );
      widget.controller
          .fetchFixtureData("65590acab19d56d5417f608f", widget.matchId);
    });

    // FixtureService.getRunningFixtures(widget.data.id, widget.matchId).then((x) {
    //   if (mounted) {
    //     if (x.isEmpty) {
    //       setState(() {
    //         showHide = false;
    //       });
    //     } else {
    //       setState(() {
    //         showHide = true;
    //       });
    //     }
    //   }
    // });
    // fetchLeagues();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

// card header
  Widget _cardHeader({String? title, String? teamLogo}) {
    BuildContext? context = navigatorKey.currentContext;
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
                child: SizedBox(),
               
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

  Widget cardContent({Datum? fixture}) {
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
                Expanded(
                  child: SizedBox(
                    width: 20,
                    child: Text(
                      fixture!.matchEnded
                          ? "FT"
                          : fixture.isLive
                              ? fixture.elapsedTime
                              : fixture.kickofftime,
                      style: textStyle.copyWith(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
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
                                child: Image.network(
                                  Apis.image + fixture.hometeam.image,
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
                                child: Image.network(
                                  Apis.image + fixture.awayteam.image,
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
                    child: fixture.isLive ? Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "${fixture.homeGoals}\n"),
                          TextSpan(text: "\n ${fixture.awayGoals}"),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ) : null,
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
              // controller.fetchLeagueData(
              //   "65590acab19d56d5417f608f",
              // );
              // controller.fetchLeagueData(
              //   "65590acab19d56d5417f608f",
              // );
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
                    ),
                  ),
                ],
              );
            }),
          );
  }
}
