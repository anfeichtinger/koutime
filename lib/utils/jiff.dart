import 'package:hive_flutter/hive_flutter.dart';
import 'package:jiffy/jiffy.dart';

class Jiff extends Jiffy {
  Jiff([super.input, super.pattern]);

  @override
  int get day {
    final List<int> weekDays = <int>[1, 2, 3, 4, 5, 6, 7, 1, 2];
    int weekDayIndex = super.dateTime.weekday - 1;

    switch (Hive.box('prefs').get('startOfWeek') as String?) {
      case 'StartOfWeek.SATURDAY':
        weekDayIndex += 2;
        break;
      case 'StartOfWeek.SUNDAY':
        weekDayIndex += 1;
        break;
      case 'StartOfWeek.MONDAY':
      default:
        weekDayIndex += 0;
        break;
    }
    return weekDays[weekDayIndex];
  }

  @override
  Jiff startOf(Units units) {
    return Jiff(super.startOf(units).dateTime);
  }

  @override
  Jiff endOf(Units units) {
    return Jiff(super.endOf(units).dateTime);
  }

  @override
  Jiff add({
    Duration duration = Duration.zero,
    int years = 0,
    int months = 0,
    int weeks = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) {
    return Jiff(super
        .add(
          duration: duration,
          years: years,
          months: months,
          weeks: weeks,
          days: days,
          hours: hours,
          minutes: minutes,
          seconds: seconds,
          milliseconds: milliseconds,
          microseconds: microseconds,
        )
        .dateTime);
  }
}
