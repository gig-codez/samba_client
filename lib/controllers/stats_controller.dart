import "/exports/exports.dart";
import '../../../models/table_model.dart';
import '../../../services/table_service.dart';

class StatsController with ChangeNotifier {
  List<Message> _tableData = [];
  List<Message> get tableData => _tableData;
  void fetchTableData() async {
    var teams = await TableService().getTeams(leagueId);
    _tableData = teams;
    notifyListeners();
  }
}
