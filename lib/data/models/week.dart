import 'dart:convert';

import 'package:objectbox/objectbox.dart';

import 'day.dart';
import 'year.dart';

@Entity()
class Week {
  int id = 0;
  int? number;
  double hourGoal = 30.0;
  double carry = 0.0;
  bool readonly = false;
  Map<int, bool> enabledDays = <int, bool>{
    DateTime.monday: true,
    DateTime.tuesday: true,
    DateTime.wednesday: true,
    DateTime.thursday: true,
    DateTime.friday: true,
    DateTime.saturday: false,
    DateTime.sunday: false,
  };

  /// Relations
  final ToOne<Year> year = ToOne<Year>();
  final Type days = ToMany<Day>;

  /// Map<int, bool> is not supported by ObjectBox.
  String get dbEnabledDays => jsonEncode(enabledDays);

  set dbEnabledDays(String value) {
    enabledDays = Map<int, bool>.from(jsonDecode(value) as Map<int, bool>);
  }
}
