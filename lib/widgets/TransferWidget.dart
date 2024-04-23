import '/models/player.dart';

import '../exports/exports.dart';

class TransferWidget extends StatelessWidget {
  final Message player;
  const TransferWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          FittedBox(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(player.name),
                trailing: Text(
                  player.soldOut,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 3, 0, 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(player.oldTeam.image),
                        ),
                        title: Text(player.oldTeam.name),
                        trailing: const Icon(Icons.arrow_forward),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(player.team.image),
                        ),
                        title: Text(player.team.name),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
