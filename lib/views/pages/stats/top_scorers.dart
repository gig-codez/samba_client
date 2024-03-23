import "../../../services/player_service.dart";
import "/exports/exports.dart";

class TopScorers extends StatefulWidget {
  final String team;
  const TopScorers({super.key, required this.team});

  @override
  State<TopScorers> createState() => _TopScorersState();
}

class _TopScorersState extends State<TopScorers> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PlayerService.getTopScorers(widget.team),
        builder: (context, snapshot) {
          var data = snapshot.data ?? [];
          print(data);
          return snapshot.hasData
              ? data.isNotEmpty ? ListView.builder(
                padding:EdgeInsets.all(10),
                  itemCount: 10,
                  itemBuilder: (context, index) => ListTile(
                    leading: const CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.person),
                    ),
                    title: Text(data[index].name),
                    subtitle: Text(data[index].team.name),
                    trailing: Text(data[index].goal.toString()),
                  ),
                ): Center(child:Text("No stats yet!!",style:Theme.of(context).textTheme.titleLarge,),)
              : const Center(child: CircularProgressIndicator.adaptive(),);
        });
  }
}
