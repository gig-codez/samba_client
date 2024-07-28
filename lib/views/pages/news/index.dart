import "../../../controllers/league_controller.dart";
import "/exports/exports.dart";
import "widget/blog_trend_card.dart";
import "widget/blog_card.dart";

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blogs"),
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
      body: Consumer<DataController>(
        builder: (context, controller, child) {
          if (mounted) {
            controller.fetchMatchDates();
            controller.fetchFixtures();
            controller.fetchFixtureData();
          }
          var blogs = controller.blogs;
          return blogs.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Flexible(
                        child: SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(3),
                            children: context
                                .read<LeagueController>()
                                .leagues
                                .map((league) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .apply(
                                            color: leagueId == league.leagueId
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .primaryColor,
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
                      Flexible(
                        flex: 5,
                        child: Column(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                "assets/empty.svg",
                                width: 300,
                                height: 300,
                              ),
                            ),
                            Text(
                              "No records found!!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(fontWeightDelta: 1),
                            ),
                          ],
                        ),
                      )
                    ])
              : Column(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(3),
                          children: context
                              .read<LeagueController>()
                              .leagues
                              .map((league) {
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(
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
                    Flexible(
                      flex: 5,
                      child: ListView.builder(
                        itemCount: blogs.length,
                        itemBuilder: (context, index) {
                          var blog = blogs[index];
                          return index == 0
                              ? BlogTrendCard(blog: blog)
                              : BlogCard(
                                  controller: _controller!,
                                  blog: blog,
                                );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
