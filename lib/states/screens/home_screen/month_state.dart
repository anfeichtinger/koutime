import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeChangeNotifierProvider<MonthState> monthProvider =
    ChangeNotifierProvider.autoDispose(
        (AutoDisposeChangeNotifierProviderRef<MonthState> ref) {
  return MonthState();
});

class MonthState extends ChangeNotifier {
  MonthState() {
    final DateTime now = DateTime.now();
    _start = DateTime(now.year, now.month);
    _end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
  }

  late DateTime _start;
  late DateTime _end;

  set start(DateTime dateTime) {
    _start = dateTime;
    notifyListeners();
  }

  DateTime get start => _start;

  set end(DateTime dateTime) {
    _end = dateTime;
    notifyListeners();
  }

  DateTime get end => _end;
}
