import 'dart:developer';

import "/exports/exports.dart";
import '../../../models/table_model.dart';
import '../../../services/table_service.dart';

class StatsController with ChangeNotifier {
  List<Message> _tableData = [];
  List<Message> get tableData => _tableData;
  void fetchTableData() {
    TableService().getTeams(leagueId).then((teams) {
      _tableData = teams;
      notifyListeners();
    });
  }

  StatsController() {
    fetchTableData();
    log("Stats invoked");
  }
}
