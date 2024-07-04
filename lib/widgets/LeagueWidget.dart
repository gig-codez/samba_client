// ignore: file_names

import '/exports/exports.dart';
import '/models/fixture.dart';
import '/models/league.dart';
import 'RunningTimeWidget.dart';

class LeagueWidget extends StatefulWidget {
  final Message data;
  final String matchId;
  const LeagueWidget({
    super.key,
    required this.data,
    required this.matchId,
  });

  @override
  State<LeagueWidget> createState() => _LeagueWidgetState();
}

class _LeagueWidgetState extends State<LeagueWidget> {
  bool showHide = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// card header
  Widget _cardHeader({String? title}) {
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
                child: const SizedBox(),
              ),
              AutoSizeText(
                title ?? "League name",
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium!.apply(
                      fontWeightDelta: 5,
                    ),
              ),
              const SizedBox.square(
                dimension: 50,
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

  Widget cardContent(
      {Datum? fixture, int? index, required Map<String, dynamic> socket}) {
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
            matchId: widget.matchId,
            index: index,
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
                                  image: CachedNetworkImageProvider(
                                      fixture!.hometeam.image),
                                  width: 44,
                                  height: 44,
                                ),
                              ),
                              const SizedBox.square(
                                dimension: 14,
                              ),
                              SizedBox(
                                width: 170,
                                child: AutoSizeText(
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
                                  image: CachedNetworkImageProvider(
                                      fixture.awayteam.image),
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
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade300
                  : Colors.white30,
            ),
          ],
        ),
      ),
    );
  }

  String msg = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<DataController>(builder: (context, controller, x) {
      controller.fetchLeagueData();
      controller.fetchFixtureData();
      return controller.fixtureData.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/empty.svg",
                    height: 150,
                    width: 150,
                  ),
                ),
                Text(
                  "No fixture yet set for today!",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // OutlinedButton.icon(onPressed: (){}, icon: icon, label: Text("Add "))
              ],
            )
          : Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              margin: const EdgeInsets.fromLTRB(10, 11, 10, 11),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[100]
                    : Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade300
                      : Colors.white30,
                ),
              ),
              child: Consumer<DataController>(
                  builder: (context, controller, child) {
                return Column(
                  children: [
                    _cardHeader(
                      title: widget.data.name,
                    ),
                    Divider(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade300
                          : Colors.white30,
                    ),
                    ...List.generate(
                      controller.fixtureData.length,
                      (i) => cardContent(
                        index: i,
                        fixture: controller.fixtureData[i],
                        socket: socketData,
                      ),
                    ),
                  ],
                );
              }),
            );
    });
  }
}
