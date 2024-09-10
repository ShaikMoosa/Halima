import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'week_data_model.dart';

class WeekProvider with ChangeNotifier {
  List<WeekData> _weeksData = [];
  WeekData? _selectedWeek;

  List<WeekData> get weeksData => _weeksData;
  WeekData? get selectedWeek => _selectedWeek;

  Future<void> loadWeeksData() async {
    final String response = await rootBundle.loadString('assets/weeks_data.json');
    final data = await json.decode(response) as List;
    _weeksData = data.map((item) => WeekData.fromJson(item)).toList();
    notifyListeners();
  }

  void selectWeek(WeekData week) {
    _selectedWeek = week;
    notifyListeners();
  }
  void selectWeekByWeek(int weekNumber) {
  // Assuming each entry in the JSON data represents a week range (e.g., 1-4, 5-8, etc.)
  for (var weekData in _weeksData) {
    final weekRange = weekData.weekRange.split('-');
    int startWeek = int.parse(weekRange[0]);
    int endWeek = int.parse(weekRange[1]);

    if (weekNumber >= startWeek && weekNumber <= endWeek) {
      _selectedWeek = weekData;
      break;
    }
  }
  notifyListeners();
}

}
