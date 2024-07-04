import '/views/pages/teamPages/table_row_widget.dart';
import '/exports/exports.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<StatsController>(context, listen: false).fetchTableData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StatsController>(builder: (context, controller, c) {
      controller.fetchTableData();
      var data = controller.tableData;
      return data.isNotEmpty
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
                          DataColumn(
                            // fixedWidth: 100,
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("#    Team"),
                                    SizedBox.square(
                                      dimension: 170,
                                    ),
                                  ],
                                ),
                                const SizedBox.square(
                                  dimension: 0,
                                ),
                                Row(
                                  children: [
                                    Text("P "),
                                    SizedBox.square(
                                      dimension: 10,
                                    ),
                                    Text("W "),
                                    SizedBox.square(
                                      dimension: 10,
                                    ),
                                    Text("D "),
                                    SizedBox.square(
                                      dimension: 10,
                                    ),
                                    Text("L "),
                                    SizedBox.square(
                                      dimension: 10,
                                    ),
                                    Text("GD "),
                                    SizedBox.square(
                                      dimension: 10,
                                    ),
                                    Text("Pts "),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                        rows: List.generate(
                          data.length,
                          (index) {
                            var teamData = data[index];
                            return TableRowWidget.drawDatRow(
                              context,
                              color: index % 2 == 0
                                  ? Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade300
                                      : Colors.white30
                                  : Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade50
                                      : Colors.white12,
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
            );
    });
  }
}
