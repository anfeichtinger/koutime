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
}
