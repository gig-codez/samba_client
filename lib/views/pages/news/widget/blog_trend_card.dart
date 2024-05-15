import "/exports/exports.dart";

class BlogTrendCard extends StatelessWidget {
  final BlogsModel blog;
  const BlogTrendCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: InkWell(
        onTap: () {
          Routes.animateToPage(
            BlogDetailPage(blog: blog),
            type: "slide",
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.trending_up,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 16,
                    ),
                  ),
                  const SizedBox.square(dimension: 10),
                  Text(
                    "Trending ",
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          fontWeightDelta: 3,
                          fontSizeDelta: 7,
                        ),
                  ),
                ],
              ),
            ),
            Image.network(
              blog.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              fit: BoxFit.cover,
            ),
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
              padding: const EdgeInsets.fromLTRB(18, 5, 5, 5),
              child: Text(
                blog.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.article,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 16,
                    ),
                  ),
                  const SizedBox.square(dimension: 10),
                  Text(
                    "Latest Articles ",
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          fontWeightDelta: 3,
                          fontSizeDelta: 7,
                        ),
                  ),
                  const SizedBox.square(dimension: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
