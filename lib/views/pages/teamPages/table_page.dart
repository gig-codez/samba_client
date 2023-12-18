import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import '../../../models/table_model.dart';
import '../../../services/table_service.dart';
import '/views/pages/teamPages/table_row_widget.dart';

import '/exports/exports.dart';

class TablePage extends StatefulWidget {
  final String leagueId;
  const TablePage({super.key, required this.leagueId});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final StreamController<List<Message>> _teamsController =
      StreamController<List<Message>>();
  Timer? _timer;
  void fetchTeams() async {
    var teams = await TableService().getTeams(widget.leagueId);
    _teamsController.add(teams);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var teams = await TableService().getTeams(widget.leagueId);
      _teamsController.add(teams);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTeams();
  }

  @override
  void dispose() {
    if (_teamsController.hasListener) {
      _teamsController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _teamsController.stream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? snapshot.data != null && snapshot.data!.isNotEmpty
                  ? SingleChildScrollView(
                      child: FittedBox(
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(2, 2, 2, 0),
                          elevation: 0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: const [
                                  DataColumn2(label: Text("#    Team")),
                                  DataColumn2(
                                    // fixedWidth: 100,
                                    label: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("P "),
                                        const SizedBox.square(
                                          dimension: 10,
                                        ),
                                        Text("W "),
                                        const SizedBox.square(
                                          dimension: 10,
                                        ),
                                        Text("D "),
                                        const SizedBox.square(
                                          dimension: 10,
                                        ),
                                        Text("L "),
                                        const SizedBox.square(
                                          dimension: 10,
                                        ),
                                        Text("GD "),
                                        const SizedBox.square(
                                          dimension: 10,
                                        ),
                                        Text("Pts "),
                                      ],
                                    ),
                               
                                  ),
                                ],
                                rows: List.generate(
                                  snapshot.data!.length,
                                  (index) {
                                    var teamData = snapshot.data![index];
                                    return TableRowWidget.drawDatRow(
                                      context,
                                      color: index % 2 == 0
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade50,
                                      id: index + 1,
                                      teamName: teamData.team.name,
                                      image: teamData.team.image,
                                      p: teamData.played,
                                      w: teamData.won,
                                      d: teamData.draw,
                                      l: teamData.lose,
                                      gd: teamData.gd,
                                      pts: teamData.points,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text("No Teams added yet"),
                    )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        });
  }
}
