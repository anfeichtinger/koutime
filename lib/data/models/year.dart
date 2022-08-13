import 'package:objectbox/objectbox.dart';

import 'week.dart';

@Entity()
class Year {
  int id = 0;
  int year = 1970;

  /// Relations
  final Type weeks = ToMany<Week>;
}
