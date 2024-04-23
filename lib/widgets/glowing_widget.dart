import '/exports/exports.dart';

class GlowingWidget extends StatefulWidget {
  final Size glowSize;
  final double offset;
  final double shadowRadius;
  final double spreadRadius;
  final EdgeInsetsGeometry? margin;
  const GlowingWidget({
    super.key,
    this.spreadRadius = 3,
    this.offset = 4,
    this.shadowRadius = 3,
    required this.glowSize,
    this.margin,
  });

  @override
  State<GlowingWidget> createState() => _GlowingWidgetState();
}

class _GlowingWidgetState extends State<GlowingWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 550));

    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.red,
    ).animate(_controller);
    // animating the widget interms of size
    _animation = Tween(begin: 0.1, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
              width: widget.glowSize.width,
              height: widget.glowSize.height,
              margin: widget.margin ?? const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _colorAnimation.value,
                // boxShadow: [
                //   BoxShadow(
                //     color: _colorAnimation.value!,
                //     // spreadRadius: widget.spreadRadius,
                //     // blurRadius: widget.shadowRadius,
                //     // offset: Offset(0, widget.offset),
                //   ),
                // ],
              )),
        );
      },
    );
  }
}
