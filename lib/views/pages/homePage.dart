import 'dart:async';
import 'dart:developer';
import '../../models/match_date.dart';
import '../../services/match_date_service.dart';
import '../../widgets/LeagueWidget.dart';
import '/exports/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? tabController;
  Timer? _timer;
  // int tabs = 0;
  int currentTab(List<MatchDateModel> match) {
    try {
      // Find the index of the match date matching today's date
      int tabIndex = match.indexWhere((element) =>
          DateTime.parse(element.date).formated() == DateTime.now().formated());

      // If no match found, look for the next upcoming match
      if (tabIndex == -1) {
        List<DateTime> matchDates =
            match.map((e) => DateTime.parse(e.date)).toList();
        matchDates.sort(); // Ensure dates are in ascending order

        DateTime nextMatchDate = matchDates.firstWhere(
          (date) => date.isAfter(
            DateTime.now(),
          ),
        );
        tabIndex = match.indexWhere(
            (element) => DateTime.parse(element.date) == nextMatchDate);
      }

      return tabIndex;
    } catch (error) {
      // Handle any potential errors during date parsing or index retrieval
      print("Error occurred: $error");
      // Consider logging or reporting the error appropriately
      return match.length - 1; // If an error occurs, default to the last index
    }
  }

  @override
  void initState() {
    super.initState();
    // setUpMessage();
    Provider.of<DataController>(context, listen: false).fetchLeagueData();
    Provider.of<DataController>(context, listen: false).fetchFixtures();

    Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      log("${timer.tick} $tabs");
      var matchDates = await MatchDateService.getMatchDates(leagueId);
      if (tabs == 0) {
        setState(() {
          tabs = matchDates.length;
        });
        tabController = TabController(
          length: matchDates.length, //P@ssw0rd?
          initialIndex: currentTab(matchDates),
          vsync: this,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    tabController?.dispose();
    super.dispose();
  }

  int debounce = 0;
  int tabs = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataController>(builder: (context, controller, child) {
      if (mounted) {
        controller.fetchMatchDates();
        controller.fetchFixtures();
        controller.fetchFixtureData();
      }

      // }
      if (tabs == 0) {
        tabController = TabController(
          length: tabs,
          // initialIndex: tabs == 0 ? 0 : tabs - 1,
          vsync: this,
        );
      }

      // debounce++;
      return Scaffold(
        appBar: AppBar(
          leading: Hero(
            tag: "splash",
            child: Image(
              image: AssetImage(leagueLogo),
            ),
          ),
          title: Text(appTitle.toUpperCase()),
        ),
        body: Column(
          children: [
            if (tabs != 0)
              TabBar(
                controller: tabController,
                isScrollable: true,
                tabs: List.generate(
                  tabs,
                  (index) {
                    //  setting global matchId
                    controller.matchId = controller.matchDates[index].id;
                    // s
                    return Tab(
                      text: DateTime.parse(controller.matchDates[index].date)
                          .formated(),
                    );
                  },
                ),
              ),
            if (tabs != 0)
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: List.generate(tabs, (i) {
                    controller.matchId = controller.matchDates[i].id;
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: SingleChildScrollView(
                        child: LeagueWidget(
                          data: controller.leagueData,
                          matchId: controller.matchDates[i].id,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            // for fau
            // TapEffect(
            //   child: Image.asset(
            //     "assets/images/betpawa.jpeg",
            //     width: MediaQuery.of(context).size.width,
            //     height: 50,
            //     fit: BoxFit.cover,
            //   ),
            //   onClick: () {
            //     launchUrl(Uri.parse("https://betpawa.com/games"),
            //         mode: LaunchMode.externalApplication);
            //   },
            // ),
          ],
        ),
      );
    });
  }
}
