import '/exports/exports.dart';

class CleanSheets extends StatefulWidget {
  const CleanSheets({super.key});

  @override
  State<CleanSheets> createState() => _CleanSheetsState();
}

class _CleanSheetsState extends State<CleanSheets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerController>(
      builder: (context, controller, c) {
        controller.fetchCleanSheets();
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
                  trailing: Text(
                    data[index].cleanSheet.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
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
