import 'package:flutter/material.dart';

import '../../../data/enums/day_usage_enum.dart';
import '../../../data/models/day.dart';
import 'home_entry/free_entry.dart';
import 'home_entry/holiday_entry.dart';
import 'home_entry/shift_entry.dart';
import 'home_entry/sick_entry.dart';

class HomeEntry extends StatelessWidget {
  const HomeEntry({super.key, required this.day});

  final Day day;

  @override
  Widget build(BuildContext context) {
    switch (day.usage) {
      case DayUsage.free:
        return FreeEntry(day: day);
      case DayUsage.holiday:
        return HolidayEntry(day: day);
      case DayUsage.sick:
        return SickEntry(day: day);
      case DayUsage.shift:
        return ShiftEntry(day: day);
    }
  }
}
