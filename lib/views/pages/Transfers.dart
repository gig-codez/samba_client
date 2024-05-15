import '/services/player_service.dart';

import '../../exports/exports.dart';
import '../../models/fixture.dart';
import '../../widgets/TransferWidget.dart';

class TransfersPage extends StatefulWidget {

  const TransfersPage({super.key});

  @override
  State<TransfersPage> createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage> {
 

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
                future: PlayerService.getTransferredPlayers(
                  leagueId),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? snapshot.data!.isEmpty ? const Center(child: Text("No transferred player yet."),) : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return TransferWidget(
                              player: snapshot.data![index],
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                }),
      ),
    );
  }
}
