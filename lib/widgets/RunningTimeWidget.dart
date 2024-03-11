import "/exports/exports.dart";
import 'glowing_widget.dart';
import '/models/fixture.dart';

class RunningTimeWidget extends StatelessWidget {
  final Datum? fixture;
  const RunningTimeWidget({super.key, this.fixture});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .apply(fontWeightDelta: 5, fontSizeDelta: 3);
    return Expanded(
      child: Stack(
        children: [
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(5),
            color: Colors.grey.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              // side: const BorderSide(
              //   color: Colors.grey,
              // ),
            ),
            child: SizedBox.square(
              dimension: 55,
              child: Center(
                child: Text(
                  timeUpdates(fixture!),
                  style: textStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          if (fixture!.isRunning == true)
            const Positioned(
              top: -11,
              right: 0,
              child: GlowingWidget(
                glowSize: Size(12, 12),
              ),
            ),
        ],
      ),
    );
  }
}
