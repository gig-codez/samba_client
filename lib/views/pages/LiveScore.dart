import '/exports/exports.dart';

class LiveScore extends StatefulWidget {
  const LiveScore({super.key});

  @override
  State<LiveScore> createState() => _LiveScoreState();
}

class _LiveScoreState extends State<LiveScore> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("LiveScore"),
    );
  }
}
