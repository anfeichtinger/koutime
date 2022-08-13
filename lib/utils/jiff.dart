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
}
