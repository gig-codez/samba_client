import '/exports/exports.dart';

class StePage extends StatefulWidget {
  const StePage({super.key});

  @override
  State<StePage> createState() => _StePageState();
}

class _StePageState extends State<StePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerController>(
      builder: (context, controller, c) {
        if (mounted) {
          controller.fetchSTE();
        }
        var data = controller.topSTE;
        return data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) => ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                  title: Text(data[index].player.name),
                  subtitle: Text(data[index].shirtNo),
                  trailing: Text(
                    data[index].ste.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
            : Center(
                child: Text(
                  "No stats for TO yet",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
      },
    );
  }
}
