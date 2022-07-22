import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/day.dart';

final AutoDisposeChangeNotifierProvider<CreateDayState> createDayProvider =
    ChangeNotifierProvider.autoDispose(
        (AutoDisposeChangeNotifierProviderRef<CreateDayState> ref) {
  return CreateDayState();
});

class CreateDayState extends ChangeNotifier {
  CreateDayState() {
    // Todo get from config
    final DateTime now = DateTime.now();
    final DateTime from = DateTime(now.year, now.month, now.day, 8);
    final DateTime until = from.add(const Duration(hours: 8, minutes: 30));
    _state = Day(from: from, to: until);
  }

  late Day _state;

  set day(Day day) {
    _state = day;
    notifyListeners();
  }

  Day get day => _state;
}
