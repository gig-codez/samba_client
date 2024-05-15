
import "/exports/exports.dart";

class TopScorers extends StatefulWidget {
  const TopScorers({super.key});

  @override
  State<TopScorers> createState() => _TopScorersState();
}

class _TopScorersState extends State<TopScorers> {
  @override
  Widget build(BuildContext context) {

    return Consumer<PlayerController>(builder: (c, controller, homeSnap) {
      controller.fetchScorers();
      var data = controller.topScorers;
      return data.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: data.length,
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
                title: Text(data[index].name),
                subtitle: Text(data[index].team.name),
                trailing: Text(data[index].goal.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
              ),
            )
          : Center(
              child: Text(
                "No stats for top scorers yet!!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
    });
  }
}
