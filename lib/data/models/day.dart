import 'package:objectbox/objectbox.dart';

import '../enums/day_usage_enum.dart';
import 'week.dart';

@Entity()
class Day {
  Day(
      {this.id = 0,
      required this.from,
      required this.to,
      this.breakFrom,
      this.breakTo,
      this.usage = DayUsage.shift,
      this.multiplier = 1.0,
      this.comment});

  int id = 0;
  @Property(type: PropertyType.date)
  DateTime from = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime to = DateTime.now().add(const Duration(hours: 8, minutes: 30));
  @Property(type: PropertyType.date)
  DateTime? breakFrom;
  @Property(type: PropertyType.date)
  DateTime? breakTo;
  DayUsage usage = DayUsage.shift;
  double multiplier = 1.0;
  String? comment;

  /// Relations
  final ToOne<Week> week = ToOne<Week>();

  /// The DayUsage enum is not supported by ObjectBox.
  /// So define a field with a supported type,
  /// that is backed by the usage field.
  int get dbUsage {
    _ensureStableEnumValues();
    return usage.index;
  }

  set dbUsage(int value) {
    _ensureStableEnumValues();
    usage = DayUsage.values[value]; // throws a RangeError if not found
  }

  void _ensureStableEnumValues() {
    assert(DayUsage.free.index == 0);
    assert(DayUsage.holiday.index == 1);
    assert(DayUsage.sick.index == 2);
    assert(DayUsage.shift.index == 3);
  }

  @override
  String toString() {
    return 'Day{id: $id, from: $from, to: $to, breakFrom: $breakFrom, breakTo: $breakTo, usage: $usage, multiplier: $multiplier, comment: $comment}';
  }
}
