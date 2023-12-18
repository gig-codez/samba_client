import 'package:intl/intl.dart';

import '../../../controllers/data_controller.dart';
import '/exports/exports.dart';
import '/services/match_date_service.dart';

class ShowMatchDates extends StatefulWidget {
  const ShowMatchDates({super.key});

  @override
  State<ShowMatchDates> createState() => _ShowMatchDatesState();
}

class _ShowMatchDatesState extends State<ShowMatchDates> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Consumer<DataController>(builder: (context, controller, child) {
          return controller.matchDates.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.matchDates.length,
                  itemBuilder: (context, index) {
                    return ProfileWidget(
                      titleText: DateFormat("EEE d MMM").format(
                        DateTime.parse(controller.matchDates[index].date),
                      ),
                      onPress: () {
                        context.read<AppController>().matchDateId = {
                          "date": DateFormat("EEE d MMM").format(
                            DateTime.parse(controller.matchDates[index].date),
                          ),
                          "id": controller.matchDates[index].id
                        };
                        Routes.popPage();
                      },
                      prefixIcon: "assets/football.svg",
                      color: Colors.green,
                      iconSize: 30,
                      size: 30,
                    );
                  },
                )
              : const Center(
                  child: Text("No match dates found"),
                );
        }),
      ),
    );
  }
}
