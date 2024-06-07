import '../models/fixture.dart';
import '/exports/exports.dart';

class FixtureController with ChangeNotifier {
  final List<Datum> _fixtures = [];
  List<Datum> get fixtures => _fixtures;

  void addFixtures(List<Datum> fixtures) {
    _fixtures.addAll(fixtures);
    notifyListeners();
  }

  void clearFixtures() {
    _fixtures.clear();
    notifyListeners();
  }
}
