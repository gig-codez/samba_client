import "/exports/exports.dart";
import '../../../models/table_model.dart';
import '../../../services/table_service.dart';

class StatsController with ChangeNotifier {
  List<Message> _tableData = [];
  List<Message> get tableData => _tableData;
  void fetchTableData() async {
    TableService().getTeams(leagueId).then((teams) {
      _tableData = teams;
      notifyListeners();
    });
  }

  // constructor invocation
  StatsController() {
    fetchTableData();
  }
}
