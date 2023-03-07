import 'package:flutter/foundation.dart';
import 'package:space/utils/pref.dart';

class PointsProvider extends ChangeNotifier {
  final int _score = SharedPreferencesHelper.getPoints();
  int get getScore => _score;
  void setScore({required int point}) {
    SharedPreferencesHelper.saveScores(point);
    notifyListeners();
  }
}
