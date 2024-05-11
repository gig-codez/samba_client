import "/exports/exports.dart";

class BlogDetailPage extends StatefulWidget {
  final BlogsModel blog;
  const BlogDetailPage({super.key, required this.blog});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: ListView(
        //  padd,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 5, 18, 0),
            child: Text(
             "${ widget.blog.title}\n",
              style: Theme.of(context).textTheme.bodyLarge!.apply(
                    fontWeightDelta: 3,
                    fontSizeDelta: 6,
                  ),
            ),
          ),
          Text(
              widget.blog.summary,
              style: Theme.of(context).textTheme.bodyLarge!.apply(
                    fontWeightDelta: 3,
                    fontSizeDelta: 6,
                  ),
            ),
          Image.asset(
            "assets/leagues/fufa.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
            child: Text(
              widget.blog.content,
            ),
          ),
        ],
      ),
    );
  }
}
