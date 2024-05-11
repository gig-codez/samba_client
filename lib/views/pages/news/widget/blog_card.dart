import "/exports/exports.dart";

class BlogCard extends StatefulWidget {
  final BlogsModel blog;
  final AnimationController controller;
  const BlogCard({super.key, required this.blog, required this.controller});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routes.animateToPage(
          BlogDetailPage(blog: widget.blog),
        );
      },
      child: Row(
        children: [
          Image.asset(
            "assets/leagues/fufa.png",
            width: 150,
            height: 100,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.blog.title,
                  style: Theme.of(context).textTheme.titleMedium!.apply(
                        fontWeightDelta: 3,
                        fontSizeDelta: 2,
                      ),
                ),
                const TextSpan(text: "\n"),
                TextSpan(
                    text:
                        "${widget.blog.content.substring(0, 37)}\n${widget.blog.content.substring(37, 70)}..."),
              ],
            ),
          )
        ],
      ),
    );
  }
}
