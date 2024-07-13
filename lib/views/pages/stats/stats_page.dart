import "/exports/exports.dart";

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  TabController? _topTabController;

  @override
  void initState() {
    super.initState();
    _topTabController = TabController(length: 9, vsync: this);
  }

  @override
  void dispose() {
    _topTabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /**  "TO": 0,
    "GLS": 0,
    "AST": 0,
    "MX": 0,
    "BLK": 0,
    "STE": 0,
    "KS": 0,
    "TWO_MIN": 0,
    "RC": 0,
     */
        Flexible(
          child: TabBar(
            tabs: const [
              // cater for handball stats
              Tab(
                text: "TO",
              ),
              Tab(
                text: "GLS",
              ),
              Tab(
                text: "AST",
              ),
              Tab(
                text: "MX",
              ),
              Tab(
                text: "BLK",
              ),
              Tab(
                text: "STE",
              ),
              Tab(
                text: "KS",
              ),
              Tab(
                text: "TWO_MIN",
              ),
              Tab(
                text: "RC",
              ),
            ],
            controller: _topTabController,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
        Flexible(
          flex: 5,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _topTabController,
            children: [],
          ),
        )
      ],
    );
  }
}
