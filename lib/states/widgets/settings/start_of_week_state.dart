import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../utils/start_of_week.dart';

final AutoDisposeChangeNotifierProvider<StartOfWeekState> startOfWeekProvider =
    ChangeNotifierProvider.autoDispose(
        (AutoDisposeChangeNotifierProviderRef<StartOfWeekState> ref) {
  return StartOfWeekState();
});

class StartOfWeekState extends ChangeNotifier {
  StartOfWeekState() {
    final String mode = Hive.box('prefs').get('startOfWeek',
        defaultValue: StartOfWeek.MONDAY.toString()) as String;
    switch (mode) {
      case 'StartOfWeek.SATURDAY':
        startOfWeek = StartOfWeek.SATURDAY;
        break;
      case 'StartOfWeek.SUNDAY':
        startOfWeek = StartOfWeek.SUNDAY;
        break;
      case 'StartOfWeek.MONDAY':
      default:
        startOfWeek = StartOfWeek.MONDAY;
        break;
    }
  }

  StartOfWeek? startOfWeek;

  void setStartOfWeek(StartOfWeek startOfWeek) {
    this.startOfWeek = startOfWeek;
    Hive.box('prefs').put('startOfWeek', startOfWeek.toString());
    notifyListeners();
  }
}
