import 'package:samba_client/services/player_service.dart';

import '../../exports/exports.dart';
import '../../models/fixture.dart';
import '../../widgets/TransferWidget.dart';

class TransfersPage extends StatefulWidget {
  final Datum data;
  const TransfersPage({super.key, required this.data});

  @override
  State<TransfersPage> createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Home Team",
            ),
            Tab(
              text: "Away Team",
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            FutureBuilder(
                future: PlayerService.getTransferredPlayers(
                    widget.data.hometeam.id),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? snapshot.data!.isEmpty ? Center(child: Text("No transferred player yet."),) : ListView.builder(
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
            FutureBuilder(
                future: PlayerService.getTransferredPlayers(
                    widget.data.awayteam.id),
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
          ],
        ),
      ),
    );
  }
}
