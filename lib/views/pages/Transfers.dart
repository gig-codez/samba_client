// import '/services/player_service.dart';
import '../../exports/exports.dart';
import '../../widgets/TransferWidget.dart';

class TransfersPage extends StatefulWidget {
  const TransfersPage({super.key});

  @override
  State<TransfersPage> createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfers"),
      ),
      body: SafeArea(
        child: Consumer<PlayerController>(builder: (context, controller, st) {
          return controller.transfers.isEmpty
              ? const Center(
                  child: Text("No transferred player yet."),
                )
              : ListView.builder(
                  itemCount: controller.transfers.length,
                  itemBuilder: (context, index) {
                    return TransferWidget(
                      player: controller.transfers[index],
                    );
                  },
                );
        }),
      ),
    );
  }
}
