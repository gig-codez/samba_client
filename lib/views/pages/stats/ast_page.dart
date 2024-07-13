import '/exports/exports.dart';

class AstPage extends StatefulWidget {
  const AstPage({super.key});

  @override
  State<AstPage> createState() => _AstPageState();
}

class _AstPageState extends State<AstPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerController>(
      builder: (context, controller, c) {
        if (mounted) {
          controller.fetchAST();
        }
        var data = controller.topAST;
        return data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) => ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                  title: Text(data[index].player),
                  subtitle: Text(data[index].shirtNo),
                  trailing: Text(
                    data[index].ast.toString(),
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
