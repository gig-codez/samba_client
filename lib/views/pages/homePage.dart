import 'dart:async';
import 'dart:developer';

import 'package:intl/intl.dart';
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
        .fetchLeagueData("65590acab19d56d5417f608f");

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Provider.of<DataController>(context, listen: false)
          .fetchLeagueData("65590acab19d56d5417f608f");
      Provider.of<DataController>(context, listen: false)
          .fetchMatchDates("65590acab19d56d5417f608f");
    });
    Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      log("${timer.tick} $tabs");
      var matchDates =
          await MatchDateService.getMatchDates("65590acab19d56d5417f608f");
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

  String _getTabLabel(DateTime date) {
    String stringDate = DateFormat('EEE d MMM').format(date);
    String currentDate = DateFormat('EEE d MMM').format(DateTime.now());
    // Customize the logic to determine the label based on the relation to the current date
    if (stringDate.split(" ").first == currentDate.split(" ").first &&
        stringDate.split(" ")[1] == currentDate.split(" ")[1] &&
        (stringDate.split(" ").last == currentDate.split(" ").last)) {
      return 'Today';
    } else if (int.parse(stringDate.split(" ")[1]) ==
            (int.parse(currentDate.split(" ")[1]) - 1) &&
        (stringDate.split(" ").last == currentDate.split(" ").last)) {
      return 'Yesterday';
    } else if (int.parse(stringDate.split(" ")[1]) ==
            (int.parse(currentDate.split(" ")[1]) + 1) &&
        (stringDate.split(" ").last == currentDate.split(" ").last)) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEE d MMM').format(date);
    }
  }

  int currentTab = 0;
  int debounce = 0;
  int tabs = 0;
  @override
  Widget build(BuildContext context) {
    Provider.of<DataController>(context, listen: false)
        .fetchLeagueData("65590acab19d56d5417f608f");
    return Consumer<DataController>(builder: (context, controller, child) {
      controller.fetchMatchDates("65590acab19d56d5417f608f");
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
          title: const Text('FUFA'),
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
