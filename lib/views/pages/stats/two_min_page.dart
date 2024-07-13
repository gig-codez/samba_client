import '/exports/exports.dart';

class TwoMinPage extends StatefulWidget {
  const TwoMinPage({super.key});

  @override
  State<TwoMinPage> createState() => _TwoMinPageState();
}

class _TwoMinPageState extends State<TwoMinPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerController>(
      builder: (context, controller, c) {
        if (mounted) {
          controller.fetchTwoMin();
        }
        var data = controller.topTwoMin;
        return data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) => ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                  title: Text(
                    data[index].player.name,
                  ),
                  subtitle: Text(data[index].shirtNo),
                  trailing: Text(
                    data[index].twoMin.toString(),
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
