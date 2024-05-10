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
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.blog.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
      body: Scaffold(
        body: ListView(
          //  padd,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 5, 18, 0),
              child: Text(
                widget.blog.title,
                style: Theme.of(context).textTheme.bodyLarge!.apply(
                      fontWeightDelta: 3,
                      fontSizeDelta: 2,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
              child: Text(
                widget.blog.content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
