import 'package:easy_localization/easy_localization.dart';
import 'package:jiffy/jiffy.dart';
import 'package:objectbox/objectbox.dart';

import '../../utils/jiff.dart';
import '../enums/day_usage_enum.dart';
import 'break.dart';
import 'week.dart';

@Entity()
class Day {
  Day(
      {this.id = 0,
      required this.from,
      required this.to,
      this.usage = DayUsage.shift,
      this.multiplier = 1.0,
      this.comment});

  int id = 0;
  @Property(type: PropertyType.date)
  DateTime from = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime to = DateTime.now().add(const Duration(hours: 8, minutes: 30));
  DayUsage usage = DayUsage.shift;
  double multiplier = 1.0;
  String? comment;

  /// Relations
  final ToMany<Break> breaks = ToMany<Break>();
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
    return 'Day{id: $id, from: $from, to: $to, usage: $usage, multiplier: $multiplier, comment: $comment}';
  }

  String getActiveHourCount() {
    if (usage != DayUsage.shift || this.from == null || this.to == null) {
      return '0';
    }
    final Jiff from = Jiff(this.from);
    final Jiff to = Jiff(this.to);

    final double workingMinutes = to.diff(from, Units.MINUTE, true).toDouble();
    double breakMinutes = 0;

    for (final Break b in breaks) {
      breakMinutes +=
          Jiff(b.to).diff(Jiff(b.from), Units.MINUTE, true).toDouble();
    }

    final double result = ((workingMinutes - breakMinutes) * multiplier) / 60;
    return result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1);
  }

  String getFormattedString() {
    String format = 'HH:mm';
    if (from.day != to.day) {
      format = 'E, HH:mm';
    }
    return '${DateFormat(format).format(from)} - ${DateFormat(format).format(to)}';
  }
}
