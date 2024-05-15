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
          BlogDetailPage(
            blog: widget.blog,
          ),
          type: "slide",
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3,8,3,8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius:BorderRadius.circular(5),
              child: Image.network(
                widget.blog.image,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox.square(dimension:5),
            AutoSizeText.rich(
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
      ),
    );
  }
}
