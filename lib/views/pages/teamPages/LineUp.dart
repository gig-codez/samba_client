import '../../../controllers/PlayerController.dart';

import '../../../exports/exports.dart';

class LineUpPage extends StatefulWidget {
  final String homeTeamId;
  final String awayTeamId;
  const LineUpPage(
      {super.key, required this.homeTeamId, required this.awayTeamId});

  @override
  State<LineUpPage> createState() => _LineUpPageState();
}

class _LineUpPageState extends State<LineUpPage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Home Team",
              ),
              Tab(
                text: "Away Team",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PlayerWidget(id: widget.homeTeamId),
                PlayerWidget(id: widget.awayTeamId),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  final String id;
  final Widget? trailing;
  const PlayerWidget({super.key, required this.id, this.trailing});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerController>(builder: (c, controller, homeSnap) {
      controller.fetchPlayers(widget.id);
      return controller.players.isNotEmpty
          ? ListView.builder(
              itemCount: controller.players.length,
              itemBuilder: (context, index) => ProfileWidget(
                iconSize: 30,
                titleText: controller.players[index].name,
                subText: controller.players[index].position,
                prefixIcon: "assets/icons/match.svg",
                trailing: widget.trailing,
                color: Colors.amber,
              ),
            )
          : const Center(
              child: Text("No Players added yet"),
            );
    });
  }
}
