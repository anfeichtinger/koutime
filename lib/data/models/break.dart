import 'package:easy_localization/easy_localization.dart';
import 'package:objectbox/objectbox.dart';

import 'day.dart';

@Entity()
class Break {
  Break({
    this.id = 0,
    required this.from,
    required this.to,
  });

  int id = 0;
  @Property(type: PropertyType.date)
  DateTime from = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime to = DateTime.now().add(const Duration(minutes: 30));

  /// Relations
  final ToOne<Day> day = ToOne<Day>();

  @override
  String toString() {
    return 'Break{id: $id, from: $from, to: $to}';
  }

  String getFormattedString() {
    String format = 'HH:mm';
    if (from.day != to.day) {
      format = 'd.m.Y HH:m,';
    }
    return '${DateFormat(format).format(from)} - ${DateFormat(format).format(to)}';
  }
}
