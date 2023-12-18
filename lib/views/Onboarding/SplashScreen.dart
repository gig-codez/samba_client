import '/exports/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
      value: 0,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
// check if the animation is completed or dismissed
    _controller.addStatusListener((status) {
      setState(() {});

      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(seconds: 2), () {
          Routes.pushReplace(Routes.home);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/lptl.png',
                height: 120,
                width: 120,
              ),
            ),
          ),
          SizedBox.square(
            dimension: MediaQuery.of(context).size.width * 0.15,
          ),
          Text(
            "THE LPTL",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          SizedBox.square(
            dimension: MediaQuery.of(context).size.width * 0.35,
          ),
          SpinKitCircle(
            size: 70,
            color: primaryColor,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.35,
          ),
          Text(
            "Powered by Samba Stats",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          SizedBox.square(
            dimension: MediaQuery.of(context).size.width * 0.2,
          ),
        ],
      ),
    );
  }
}
