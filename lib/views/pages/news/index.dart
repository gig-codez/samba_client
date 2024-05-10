import "/exports/exports.dart";

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DataController>(
        builder: (context, controller, child) {
          var blogs = controller.blogs;
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              var blog = blogs[index];
              return InkWell(
                onTap: () {
                  Routes.animateToPage(BlogDetailPage(blog: blog));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      blog.image,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      fit: BoxFit.cover,
                    ),
                    // CachedNetworkImage(
                    //   imageUrl: blog.image,
                    //   placeholder: (context, url) => const SpinKitFadingCircle(
                    //     color: Colors.blue,
                    //     size: 50.0,
                    //   ),
                    //   errorWidget: (context, url, error) =>
                    //       const Icon(Icons.error),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 5, 18, 0),
                      child: Text(
                        blog.title,
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              fontWeightDelta: 3,
                              fontSizeDelta: 2,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                      child: Text(
                        blog.content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
