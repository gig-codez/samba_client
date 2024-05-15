import '/exports/exports.dart';

class TopAsists extends StatefulWidget {

  const TopAsists({super.key,});

  @override
  State<TopAsists> createState() => _TopAsistsState();
}

class _TopAsistsState extends State<TopAsists> {
  @override
  Widget build(BuildContext context) {
    // PlayerService.getTopAssists(widget.team);
    return Consumer<PlayerController>(
      builder: (context, controller, c) {
        controller.fetchAssists();
        var data = controller.topAssists;
        return data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) => ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                  title: Text(data[index].name),
                  subtitle: Text(data[index].team.name),
                  trailing: Text(
                    data[index].goal.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
            : Center(
                child: Text(
                  "No stats for assists yet",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
      },
    );
  }
}
