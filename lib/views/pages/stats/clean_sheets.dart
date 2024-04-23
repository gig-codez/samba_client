import '../../../services/player_service.dart';
import '/exports/exports.dart';

class CleanSheets extends StatefulWidget {
  final String team;
  const CleanSheets({super.key, required this.team});

  @override
  State<CleanSheets> createState() => _CleanSheetsState();
}

class _CleanSheetsState extends State<CleanSheets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerController>(
      builder: (context, controller, c) {
        controller.fetchCleanSheets(widget.team);
        var data = controller.topCleanSheets;
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
                  trailing: Text(data[index].goal.toString(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                ),
              )
            : Center(
                child: Text(
                  "No stats for clean sheets yet",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
      },
    );
  }
}
