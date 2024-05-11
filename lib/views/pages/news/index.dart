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
      body: Consumer<DataController>(
        builder: (context, controller, child) {
          var blogs = controller.blogs;
          return blogs.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Center(
                        child: SvgPicture.asset(
                          "assets/empty.svg",
                          width: 300,
                          height: 300,
                        ),
                      ),
                      Text(
                        "No Articles found!!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(fontWeightDelta: 1),
                      ),
                    ])
              : ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    var blog = blogs[index];
                    return index == 0
                        ? BlogTrendCard(blog: blog)
                        :BlogCard(controller:_controller!,blog:blog,)
                        ;
                  },
                );
        },
      ),
    );
  }
}
