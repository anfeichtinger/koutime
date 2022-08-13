import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../../../utils/jiff.dart';

final AutoDisposeChangeNotifierProvider<WeekState> weekProvider =
    ChangeNotifierProvider.autoDispose(
        (AutoDisposeChangeNotifierProviderRef<WeekState> ref) {
  return WeekState();
});

class WeekState extends ChangeNotifier {
  WeekState() {
    _start = Jiff().startOf(Units.WEEK).dateTime;
    _end = Jiff().endOf(Units.WEEK).dateTime;
  }

  late DateTime _start;
  late DateTime _end;

  set start(DateTime dateTime) {
    _start = Jiff(dateTime).startOf(Units.WEEK).dateTime;
    notifyListeners();
  }

  DateTime get start => _start;

  set end(DateTime dateTime) {
    _end = Jiff(dateTime).endOf(Units.WEEK).dateTime;
    notifyListeners();
  }

  DateTime get end => _end;

  void setWeek(DateTime time) {
    _start = Jiff(time).startOf(Units.WEEK).dateTime;
    _end = Jiff(time).endOf(Units.WEEK).dateTime;
    notifyListeners();
  }
}
