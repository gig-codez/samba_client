// ignore_for_file: non_constant_identifier_names

import "/exports/exports.dart";
import '../../../models/table_model.dart';
import '../../../services/table_service.dart';

class StatsController with ChangeNotifier {
  List<Message> _tableData = [];
  List<Message> get tableData => _tableData;
  // loading
  bool _table_loading = true;
  bool get table_loading => _table_loading;

  void fetchTableData() async {
    TableService().getTeams(leagueId).then((teams) {
      _tableData = teams;
      _table_loading = false;
      notifyListeners();
    });
  }

  // constructor invocations
  StatsController() {
    fetchTableData();
  }
}
