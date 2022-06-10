import 'package:objectbox/objectbox.dart';

import 'week.dart';

@Entity()
class Month {
  int id = 0;
  int year = 1970;
  int number = 1;
  double carry = 0.0;
  bool readonly = false;

  /// Relations
  final Type weeks = ToMany<Week>;
}
