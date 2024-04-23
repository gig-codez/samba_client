import 'dart:async';
import 'dart:developer';

import '../../controllers/data_controller.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../../main.dart';
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

        DateTime nextMatchDate =
            matchDates.firstWhere((date) => date.isAfter(DateTime.now(),),);
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
    Provider.of<DataController>(context, listen: false)
        .fetchLeagueData(leagueId);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Provider.of<DataController>(context, listen: false)
          .fetchLeagueData(leagueId);
      Provider.of<DataController>(context, listen: false)
          .fetchMatchDates(leagueId);
    });
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DataController>(context, listen: false)
        .fetchLeagueData(leagueId);
  }

  int debounce = 0;
  int tabs = 0;
  @override
  Widget build(BuildContext context) {
    Provider.of<DataController>(context, listen: false)
        .fetchLeagueData(leagueId);
    return Consumer<DataController>(builder: (context, controller, child) {
      controller.fetchMatchDates(leagueId);
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
          leading: Image(
            image: AssetImage(leagueLogo),
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
                  (index) => Tab(
                    text: DateTime.parse(controller.matchDates[index].date)
                        .formated(),
                  ),
                ),
              ),
            if (tabs != 0)
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: List.generate(
                    tabs,
                    (i) => Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: SingleChildScrollView(
                        child: LeagueWidget(
                          data: controller.leagueData,
                          matchId: controller.matchDates[i].id,
                          controller: controller,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            // for fau
            TapEffect(
              child: Image.asset(
                "assets/images/betpawa.jpeg",
                width: MediaQuery.of(context).size.width,
                height: 50,
                fit: BoxFit.cover,
              ),
              onClick: () {
                launchUrl(Uri.parse("https://betpawa.com/games"),
                    mode: LaunchMode.externalApplication);
              },
            ),
          ],
        ),
      );
    });
  }
}
