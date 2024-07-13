import '/exports/exports.dart';

class RcPage extends StatefulWidget {
  const RcPage({super.key});

  @override
  State<RcPage> createState() => _RcPageState();
}

class _RcPageState extends State<RcPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerController>(
      builder: (context, controller, c) {
        if (mounted) {
          controller.fetchRC();
        }
        var data = controller.topRC;
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
                    data[index].rc.toString(),
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
