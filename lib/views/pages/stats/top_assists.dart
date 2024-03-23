import '../../../services/player_service.dart';
import '/exports/exports.dart';

class TopAsists extends StatefulWidget {
  final String team;
  const TopAsists({super.key, required this.team});

  @override
  State<TopAsists> createState() => _TopAsistsState();
}

class _TopAsistsState extends State<TopAsists> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PlayerService.getTopAssists(widget.team),
      builder: (context, snapshot) {
        var data = snapshot.data ?? [];
        return snapshot.hasData
            ? data.isNotEmpty ? ListView.builder(
                itemCount: 10,
                padding:EdgeInsets.all(10),
                itemBuilder: (context, index) => ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                  title: Text(data[index].name),
                  subtitle: Text(data[index].team.name),
                  trailing: Text(
                    data[index].goal.toString(),
                  ),
                ),
              ) : Center(child:Text("No stats for assists yet",style:Theme.of(context).textTheme.titleMedium,),)
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              );
      },
    );
  }
}
