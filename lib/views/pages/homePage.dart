import 'dart:async';
import 'dart:developer';

import '../../controllers/data_controller.dart';

import '../../main.dart';
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

  @override
  void initState() {
    super.initState();
    setUpMessage();
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
      var matchDates =
          await MatchDateService.getMatchDates(leagueId);
      if (tabs == 0) {
        setState(() {
          tabs = matchDates.length;
        });
        tabController = TabController(
          length: matchDates.length, //P@ssw0rd?
          initialIndex: matchDates.length - 1,
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
  int currentTab = 0;
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
          initialIndex: tabs == 0 ? 0 : tabs - 1,
          vsync: this,
        );
      }

      // debounce++;
      return Scaffold(
        appBar: AppBar(
          leading: const Image(
            image: AssetImage("assets/leagues/fufa.png"),
          ),
          title:  Text(appTitle),
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
                    text: DateTime.parse(controller.matchDates[index].date).formated(),
                    
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
          ],
        ),
      );
    });
  }
}
