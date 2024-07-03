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
          // type: "slide",
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 3, 0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Hero(
                tag: widget.blog.id,
                child: Image.network(
                  widget.blog.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox.square(dimension: 10),
            Hero(
              tag: widget.blog.title,
              child: AutoSizeText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${widget.blog.title.substring(0, 38)}...",
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            fontWeightDelta: 3,
                            fontSizeDelta: 1,
                          ),
                    ),
                    const TextSpan(text: "\n"),
                    TextSpan(
                      text:
                          "${widget.blog.content.substring(0, 37)}\n${widget.blog.content.substring(37, 70)}...",
                      style: Theme.of(context).textTheme.bodySmall!.apply(),
                    ),
                  ],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
